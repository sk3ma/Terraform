/* S3 backup bucket */
resource "aws_s3_bucket" "levon_backup_bucket" {
  bucket = "levon-backup-bucket"
  force_destroy = true

  tags = {
    Name = "BackupBucket"
  }
}

/* Enable versioning for the bucket */
resource "aws_s3_bucket_versioning" "levon_backup_bucket_versioning" {
  bucket = aws_s3_bucket.levon_backup_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

/* S3 object ownership */
resource "aws_s3_bucket_public_access_block" "public_block" {
  bucket = aws_s3_bucket.levon_backup_bucket.bucket

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
}

/* Create logging Bucket */
resource "aws_s3_bucket" "logging_bucket" {
  bucket = "levon-logging-bucket"
#  acl    = "log-delivery-write"

  tags = {
    Name = "LoggingBucket"
  }
}

/* Enable logging for bucket */
resource "aws_s3_bucket_logging" "levon_backup_bucket_logging" {
  bucket = aws_s3_bucket.levon_backup_bucket.bucket

  target_bucket = aws_s3_bucket.logging_bucket.bucket
  target_prefix = "logs/"
}

/* S3 bucket retention */
resource "aws_s3_bucket_lifecycle_configuration" "bucket-config" {
  bucket = aws_s3_bucket.levon_backup_bucket.id
  rule {
    id = "archival"

    filter {
      and {
        prefix = "/"

        tags = {
          rule      = "archival"
          autoclean = "false"
        }
      }
    }

    status = "Enabled"
    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = 60
      storage_class = "GLACIER"
    }
  }
}
