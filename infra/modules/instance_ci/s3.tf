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

resource "local_file" "inventory" {
  content = templatefile(format("%s/ansible/inventory.yml", path.module), {
    WORDPRESS_PRIVATE_IP = var.wordpress_private_ip,
    DATABASE_PRIVATE_IP = var.database_private_ip,
    TRAEFIK_PUBLIC_IP   = var.traefik_public_ip
  })
  filename = format("%s/ansible/inventory_created.yml", path.module)
}

resource "null_resource" "upload_files" {
  provisioner "local-exec" {
    command = <<EOT
    aws s3 cp ${format("${path.module}/%s", "ansible")} s3://${aws_s3_bucket.bucket.bucket}/ansible --recursive
    EOT
  }


}
# # resource “null_resource” “upload_files” {

# # }
# resource "aws_s3_object" "ansible" {
#   for_each = fileset("${path.module}/ansible", "*")
#   bucket   = aws_s3_bucket.bucket.id
#   key      = join("", ["ansible/", each.value])
#   source   = format("%s/ansible/${each.value}", path.module)
# }

resource "aws_s3_object" "ansible_inventory" {
  bucket   = aws_s3_bucket.bucket.id
  key      = join("", ["ansible/", "inventory.yml"])
  source   = format("%s/ansible/inventory_created.yml", path.module)
  depends_on = [ local_file.inventory ]
}

