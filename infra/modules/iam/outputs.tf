output "iam_role_arn" {
  value = aws_iam_role.servicecatalog_launch_role.arn
}

output "policy_arn" {
  value = aws_iam_policy.ec2_servicecatalog_policy.arn
}
