resource "aws_iam_role" "ecs_task_execution_role" {
  name               = "${var.name}-ecs-task-execution-role"
  assume_role_policy = file("${path.module}/files/iam/ecs_task_execution_role_policy.json")
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy_attach" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role" "task_role" {
  name               = "ecs_tasks-${var.name}-role"
  assume_role_policy = file("${path.module}/files/iam/ecs_task_role_policy.json")
}
