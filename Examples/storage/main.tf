terraform {
  required_providers {
	aws = {
	  source  = "hashicorp/aws"
	  version = "5.99.1"
	}
  }
}

# OPTIONAL: Remote state backend (uncomment and configure if you use an S3 backend)
# terraform {
#   backend "s3" {
#     bucket         = var.remote_state_bucket
#     key            = "terraform/state/storage/terraform.tfstate"
#     region         = var.region
#     dynamodb_table = var.lock_table           # for state locking (recommended)
#     encrypt        = true
#   }
# }

# S3 bucket

resource "aws_s3_bucket" "my-bucket" {
  bucket = var.bucket_name

  tags = merge(
    var.tags,
    {
      Name = var.bucket_name
    }
  )

}

resource "aws_s3_account_public_access_block" "default" {
  bucket = aws_s3_bucket.my-bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Server-side encryption by default
resource "aws_s3_bucket_server_side_encryption_configuration" "my-encyption" {
  bucket = aws_s3_bucket.my-bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Versioning
resource "aws_s3_bucket_versioning" "my-version" {
  bucket = aws_s3_bucket.my-bucket.id
  versioning_configuration {
    status = var.versioning ? "Enabled" : "Suspended"
  }
}

# Example lifecycle rule: transition noncurrent versions after 30 days (adjust as needed)
resource "aws_s3_bucket_lifecycle_configuration" "my-lifecycle" {
  bucket = aws_s3_bucket.my-bucket.id

  rule {
    id     = "expire-noncurrent-versions"
    status = "Enabled"

    noncurrent_version_transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    noncurrent_version_expiration {
      days = 365
    }
  }
}
