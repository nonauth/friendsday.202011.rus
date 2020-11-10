resource "aws_iam_role" "this" {
  name                  = var.name
  assume_role_policy    = data.aws_iam_policy_document.assume.json
  path                  = var.iam_path
  force_detach_policies = true
  tags                  = var.tags
}

resource "aws_iam_instance_profile" "this" {
  name = var.name
  path = var.iam_path
  role = aws_iam_role.this.name
}

resource "aws_iam_policy" "this" {
  name   = var.name
  path   = var.iam_path
  policy = data.aws_iam_policy_document.this.json
}

resource "aws_iam_role_policy_attachment" "this" {
  policy_arn = aws_iam_policy.this.arn
  role       = aws_iam_role.this.name
}
