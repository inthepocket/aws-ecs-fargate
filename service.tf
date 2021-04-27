resource "aws_ecs_service" "main" {
  name            = "${var.name}-service"
  cluster         = var.cluster_id
  task_definition = aws_ecs_task_definition.main.arn
  desired_count   = var.desired_count
  launch_type     = "FARGATE"

  network_configuration {
    security_groups = var.security_groups
    subnets         = var.private_subnet_ids
  }

  dynamic "load_balancer" {
    for_each = var.lb_target_group_arns
    content {
      target_group_arn = load_balancer.value
      container_name   = var.container_name
      container_port   = var.container_port
    }
  }

  depends_on = [
    aws_ecs_task_definition.main,
  ]
}
