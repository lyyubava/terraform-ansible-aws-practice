resource "aws_kms_key" "this" {
  description             = format("encryption key for the stateful %s instance", var.name)
  deletion_window_in_days = 30
  policy                  = data.aws_iam_policy_document.this_key.json
}

data "aws_iam_policy_document" "this_key" {
  statement {
    effect = "Allow"

    actions = [
      "kms:*",
    ]

    principals {
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.whoami.account_id}:root",
      ]

      type = "AWS"
    }

    resources = [
      "*",
    ]
  }
}
