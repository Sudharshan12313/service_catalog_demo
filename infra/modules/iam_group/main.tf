resource "aws_iam_group" "servicecatalog_group" {
  name = var.group_name
}

resource "aws_iam_group_policy_attachment" "sc_group_policy_attachment" {
  group      = aws_iam_group.servicecatalog_group.name
  policy_arn = "arn:aws:iam::aws:policy/AWSServiceCatalogEndUserFullAccess"
}

resource "aws_iam_group_policy_attachment" "resource_group_policy_attachment" {
  group      = aws_iam_group.servicecatalog_group.name
  policy_arn = "arn:aws:iam::aws:policy/AWSResourceGroupsReadOnlyAccess"
}
