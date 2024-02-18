resource "aws_iam_instance_profile" "this" {
  name = var.name
  role =  aws_iam_role.this.name
}

data "aws_iam_policy_document" "instance_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "this" {
  name               = var.name
  assume_role_policy = data.aws_iam_policy_document.instance_assume_role.json
}

data "aws_iam_policy_document" "this" {


  statement {
    effect = "Allow"

    actions = [
      "ssm:GetParameter",
      "ssm:GetParameters",
      "ssm:GetParametersByPath",
    ]

    resources = [
      "*"
    ]
  }
}

resource "aws_iam_policy" "this" {
  name = format("%s_general_policy", var.name)
  path = "/"

  policy = data.aws_iam_policy_document.this.json
}

resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.this.arn
}
