data "aws_iam_policy_document" "emr_editor" {
  statement {
    sid    = "EMREditors"
    effect = "Allow"

    actions = [
      "emr:StartEditor",
      "emr:StopEditor",
      "emr:OpenEditorInConsole",
      "emr:ListEditors",
      "emr:DescribeEditors",
      "emr:CreateEditor",
    ]

    resources = ["*"]
  }
}
