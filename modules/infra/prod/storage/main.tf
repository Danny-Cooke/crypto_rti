resource "aws_s3_bucket" "data" {
  bucket = "${var.storage_s3_bucket_prefix}-${var.common_environment}-${var.common_region}"

  tags = {
    Name        = "${var.common_project}-${var.common_environment}-data"
    Environment = var.common_environment
    Project     = var.common_project
  }
}

resource "aws_s3_bucket_versioning" "data" {
  bucket = aws_s3_bucket.data.id

  versioning_configuration {
    status = var.storage_s3_enable_versioning ? "Enabled" : "Suspended"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "data" {
  bucket = aws_s3_bucket.data.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "data" {
  bucket = aws_s3_bucket.data.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "vpc_only" {
  bucket = aws_s3_bucket.data.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "DenyNonVpcAccess"
        Effect    = "Deny"
        Principal = "*"
        Action    = "s3:*"
        Resource = [
          aws_s3_bucket.data.arn,
          "${aws_s3_bucket.data.arn}/*"
        ]
        Condition = {
          StringNotEquals = {
            "aws:sourceVpce" = var.storage_s3_vpc_endpoint_id
          }
        }
      }
    ]
  })

  depends_on = [aws_s3_bucket_public_access_block.data]
}

resource "aws_s3_bucket_lifecycle_configuration" "data" {
  bucket = aws_s3_bucket.data.id

  rule {
    id     = "raw-to-ia"
    status = "Enabled"

    filter {
      prefix = "raw/"
    }

    transition {
      days          = var.storage_s3_raw_lifecycle_ia_days
      storage_class = "STANDARD_IA"
    }
  }

  rule {
    id     = "raw-to-glacier"
    status = var.storage_s3_raw_lifecycle_glacier_days > 0 ? "Enabled" : "Disabled"

    filter {
      prefix = "raw/"
    }

    transition {
      days          = var.storage_s3_raw_lifecycle_glacier_days
      storage_class = "GLACIER"
    }
  }
}
