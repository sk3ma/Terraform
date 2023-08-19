/* Create IAM policy */
resource "aws_iam_policy" "bucket_policy" {
  name        = "S3BucketPolicy"
  description = "IAM policy for S3 bucket access"

  policy = <<STOP
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:PutObject",
        "s3:GetObject"
      ],
      "Resource": "arn:aws:s3:::${aws_s3_bucket.levon_backup_bucket.id}/*"
    }
  ]
}
STOP
}

/* Using IAM role */
resource "aws_iam_role" "bucket_access_role" {
  name = "S3BucketAccessRole"

  assume_role_policy = <<STOP
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "s3.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
STOP
}

resource "aws_iam_role_policy_attachment" "bucket_policy_attachment" {
  role       = aws_iam_role.bucket_access_role.name
  policy_arn = aws_iam_policy.bucket_policy.arn
}
