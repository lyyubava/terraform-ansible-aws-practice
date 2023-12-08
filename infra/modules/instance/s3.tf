resource "random_uuid" "uuid" {}

resource "aws_s3_bucket" "bucket" {
  bucket        = "${var.name}-${random_uuid.uuid.result}"
  force_destroy = false
}

resource "aws_s3_bucket_public_access_block" "access_block" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "encryption_config" {
  bucket = aws_s3_bucket.bucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.this.arn
    }
  }
}

resource "aws_s3_object" "ebsctl" {
  for_each = fileset("${path.module}/scripts/ebsctl", "*")
  bucket   = aws_s3_bucket.bucket.id
  key      = join("", ["ebsctl/", each.value])
  source   = format("%s/scripts/ebsctl/${each.value}", path.module)
}
