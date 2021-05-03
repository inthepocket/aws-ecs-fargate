output "task_role_arn" {
  description = "The Amazon Resource Name (ARN) specifying the task role"
  value       = aws_iam_role.task_role.arn
}

output "task_role_id" {
  description = "The task role id"
  value       = aws_iam_role.task_role.id
}

output "task_execution_role_arn" {
  description = "The Amazon Resource Name (ARN) specifying the task execution role"
  value       = aws_iam_role.ecs_task_execution_role.arn
}

output "task_execution_role_id" {
  description = "The task execution role id"
  value       = aws_iam_role.ecs_task_execution_role.id
}
