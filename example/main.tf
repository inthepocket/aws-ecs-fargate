provider "aws" {
  region = "eu-west-1"
}

locals {
  service_name = "test-service"
}

resource "aws_ecs_cluster" "test_service_cluster" {
  name = local.service_name
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

module "test_service_fargate" {
  source = "../."

  name                 = local.service_name
  container_image_name = "hello-world"
  container_image_tag  = "latest"
  container_name       = local.service_name
  cluster_id           = aws_ecs_cluster.test_service_cluster.id
  cluster_name         = aws_ecs_cluster.test_service_cluster.name
  private_subnet_ids   = module.vpc.private_subnets
  security_groups      = []
  lb_target_group_arns = []
}

resource "aws_iam_role_policy" "test_service_task_role_policy" {
  name = "${local.service_name}-task-role-policy"
  role = module.test_service_fargate.task_role_id

  policy = jsonencode(
    {
      Version = "2012-10-17"
      Statement = [
        {
          Effect   = "Allow",
          Resource = ["*"],
          Action = [
            "kms:Decrypt",
            "secretsmanager:GetSecretValue"
          ]
        }
      ]
  })
}
