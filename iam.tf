locals {
  iam_group_name        = "${var.name_prefix}-iam-group"
  iam_policy_name       = "${var.name_prefix}-iam-policy"
  iam_role_name         = "${var.name_prefix}-iam-role"
  instance_profile_name = "${var.name_prefix}-iam-instance-profile"
}

resource "aws_iam_group" "this" {
  name = local.iam_group_name
}

resource "aws_iam_policy" "s3_write" {
  name        = local.iam_policy_name
  description = "Allows write-only access to the S3 bucket ${var.bucket_name}"

  policy = templatefile("${path.module}/policy.json", {
    bucket_name = var.bucket_name
  })
}

resource "aws_iam_role" "this" {
  name = local.iam_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "sts:AssumeRole"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "s3_write" {
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.s3_write.arn
}

resource "aws_iam_instance_profile" "this" {
  name = local.instance_profile_name
  role = aws_iam_role.this.name
}