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

resource "aws_iam_policy" "emr_editor" {
  name_prefix = "${var.common_prefix}-emr-editor"
  path        = var.iam_path
  policy      = data.aws_iam_policy_document.emr_editor.json
}

resource "aws_iam_user_policy_attachment" "emr_editor" {
  for_each = var.users

  user       = aws_iam_user.users[each.key].name
  policy_arn = aws_iam_policy.emr_editor.arn

  depends_on = [
    aws_iam_user.users,
  ]
}
