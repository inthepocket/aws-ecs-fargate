output "task_role_arn" {
  description = "The Amazon Resource Name (ARN) specifying the role"
  value       = aws_iam_role.task_role.arn
}

output "task_role_id" {
  description = "The task role id"
  value       = aws_iam_role.task_role.id
}
