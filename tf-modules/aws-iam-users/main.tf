resource "aws_iam_user" "users" {
  for_each = var.users

  name          = each.key
  path          = var.iam_path
  tags          = var.tags
  force_destroy = true
}

resource "null_resource" "update_login_profile" {
  for_each = var.users

  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    command = <<-EOF
      aws iam create-login-profile --user-name ${each.key} --password ${each.value} --no-password-reset-required || \
      aws iam update-login-profile --user-name ${each.key} --password ${each.value} --no-password-reset-required
    EOF
  }

  depends_on = [
    aws_iam_user.users,
  ]
}

resource "aws_iam_user_policy_attachment" "readonly" {
  for_each = var.users

  user       = aws_iam_user.users[each.key].name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"

  depends_on = [
    aws_iam_user.users,
  ]
}

resource "aws_iam_user_policy_attachment" "ec2fullaccess" {
  for_each = var.users

  user       = aws_iam_user.users[each.key].name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"

  depends_on = [
    aws_iam_user.users,
  ]
}

resource "aws_iam_policy" "s3_rw" {
  name_prefix = "${var.common_prefix}-s3rw"
  path        = var.iam_path
  policy      = data.aws_iam_policy_document.s3.json
}

resource "aws_iam_user_policy_attachment" "s3_rw" {
  for_each = var.users

  user       = aws_iam_user.users[each.key].name
  policy_arn = aws_iam_policy.s3_rw.arn

  depends_on = [
    aws_iam_user.users,
  ]
}
