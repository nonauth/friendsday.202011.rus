data "aws_iam_policy_document" "s3" {
  statement {
    sid    = "S3FullAccess"
    effect = "Allow"

    actions = [
      "s3:*",
    ]

    resources = var.s3_rw_prefixes
  }
}
