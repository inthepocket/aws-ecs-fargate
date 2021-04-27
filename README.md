# ITP AWS ECS Fargate Terraform Module

A Terraform module which creates Fargate ECS resources on AWS.

## Usage

```hcl
module "ecs_fargate" {
  source = "github.com/inthepocket/aws-ecs-fargate"

  name                 = "my-ecs-fargate-service"
  container_image_name = "hello-world"
  container_image_tag  = "latest"
  container_name       = "hello-world-container"
  cluster_id           = aws_ecs_cluster.ecs_cluster.id
  cluster_name         = aws_ecs_cluster.ecs_cluster.name
  private_subnet_ids   = module.vpc.private_subnets
  security_groups      = []
  lb_target_group_arns = []
}

resource "aws_ecs_cluster" "ecs_cluster" {
  name = "my-cluster"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}
```
