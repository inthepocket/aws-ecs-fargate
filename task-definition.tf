# App Container Definition
module "app_container_definition" {
  source                       = "git::https://github.com/cloudposse/terraform-aws-ecs-container-definition.git?ref=tags/0.45.2"
  container_name               = var.container_name
  container_image              = "${var.container_image_name}:${var.container_image_tag}"
  container_memory             = var.container_memory
  container_cpu                = var.container_cpu
  container_memory_reservation = var.container_memory_reservation
  port_mappings                = var.container_port_mappings
  essential                    = true
  environment                  = var.container_environment
  log_configuration            = var.container_log_configuration
  secrets                      = var.container_secrets
}

resource "aws_ecs_task_definition" "main" {
  family                   = "${var.name}-td"
  task_role_arn            = aws_iam_role.task_role.arn
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.container_cpu
  memory                   = var.container_memory
  container_definitions    = "[${module.app_container_definition.json_map_encoded}]"
}
