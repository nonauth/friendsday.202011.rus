resource "aws_iam_role" "this" {
  name                  = var.name
  assume_role_policy    = data.aws_iam_policy_document.assume.json
  path                  = var.iam_path
  force_detach_policies = true
  tags                  = var.tags
}

resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.this.name
  policy_arn = var.policy_arn
}

resource "aws_iam_role_policy_attachment" "dynamodb" {
  role       = aws_iam_role.this.name
  policy_arn = var.policy_dynamodb_arn
}
