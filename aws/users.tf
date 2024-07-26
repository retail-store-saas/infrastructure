resource "aws_iam_user" "breakglass_administrator" {
  name = "breakglass_administrator"
}

resource "aws_iam_user_group_membership" "breakglass_administrator" {
  user = aws_iam_user.breakglass_administrator.name

  groups = [
    aws_iam_group.administrators.name
  ]
}

resource "aws_iam_group" "administrators" {
  name = "Administrators"
}

resource "aws_iam_group_policy_attachment" "organization_administrator" {
  group      = aws_iam_group.administrators.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
