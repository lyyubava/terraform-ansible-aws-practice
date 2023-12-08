data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = var.bucket
    key    = "vpc"
    region = var.region
  }
}
