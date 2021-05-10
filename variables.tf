#------------------------------------------------------------------------------
# Misc
#------------------------------------------------------------------------------
variable "name" {
  type        = string
  description = "The name of the application and the family"
}

#------------------------------------------------------------------------------
# AWS Networking
#------------------------------------------------------------------------------
variable "private_subnet_ids" {
  type        = list(string)
  description = "IDs for private subnets"
}

#------------------------------------------------------------------------------
# AWS ECS Cluster
#------------------------------------------------------------------------------
variable "cluster_id" {
  type        = string
  description = "Cluster ID"
}

variable "cluster_name" {
  type        = string
  description = "Ecs cluster name"
}

#------------------------------------------------------------------------------
# AWS ECS Container Definition Variables
#------------------------------------------------------------------------------
variable "container_port" {
  type        = number
  description = "Port on which the container is listening"
  default     = 3000
}

variable "container_image_name" {
  type        = string
  description = "Container image name (without tag) to be used for application in task definition file"
}

variable "container_image_tag" {
  type        = string
  description = "Container image tag to be used for application in task definition file"
}

variable "container_name" {
  type        = string
  description = "Container image name to be used for application in task definition file"
}

variable "container_cpu" {
  type        = number
  description = "Container cpu allocation"
  default     = 256 # 1024 = 1 vCPU
}

variable "container_memory" {
  type        = number
  description = "Container memory allocation"
  default     = 512 # 1024 = 1GB
}

variable "container_memory_reservation" {
  type        = number
  description = "Container memory reservation"
  default     = 256 # 1024 = 1GB
}

variable "container_port_mappings" {
  type = list(object({
    containerPort = number
    hostPort      = number
    protocol      = string
  }))

  description = "The port mappings to configure for the container. This is a list of maps. Each map should contain \"containerPort\", \"hostPort\", and \"protocol\", where \"protocol\" is one of \"tcp\" or \"udp\". If using containers in a task with the awsvpc or host network mode, the hostPort can either be left blank or set to the same value as the containerPort"

  default = [
    {
      containerPort = 3000
      hostPort      = 3000
      protocol      = "tcp"
    }
  ]
}

variable "container_environment" {
  description = "(Optional) The container_environment variables to pass to the container. This is a list of maps"
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}

variable "container_secrets" {
  description = "(Optional) The secrets to pass to the container. This is a list of maps"
  type = list(object({
    name      = string
    valueFrom = string
  }))
  default = []
}

variable "container_log_configuration" {
  description = "(Optional) Log configuration options to send to a custom log driver for the container. For more details, see https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_LogConfiguration.html"
  type = object({
    logDriver = string
    options   = map(string)
    secretOptions = list(object({
      name      = string
      valueFrom = string
    }))
  })
  default = null
}

#------------------------------------------------------------------------------
# AWS ECS Service and scaling
#------------------------------------------------------------------------------
variable "lb_target_group_arns" {
  type        = list(string)
  description = "ARNs of load balancer target groups."
  default     = []
}

variable "security_groups" {
  description = "(Optional) The security groups associated with the task or service. If you do not specify a security group, the default security group for the VPC is used."
  type        = list(string)
  default     = []
}

variable "desired_count" {
  description = "(Optional) The number of instances of the task definition to place and keep running. Defaults to 0."
  type        = number
  default     = 1
}

variable "min_capacity" {
  description = "The minimal number of instances of the task definition to place and keep running"
  type        = number
  default     = 1
}

variable "max_capacity" {
  description = "The minimal number of instances of the task definition to place and keep running"
  type        = number
  default     = 50
}

variable "max_cpu_threshold" {
  description = "Threshold for max CPU usage"
  default     = "85"
  type        = string
}

variable "min_cpu_threshold" {
  description = "Threshold for min CPU usage"
  default     = "10"
  type        = string
}

variable "max_cpu_evaluation_period" {
  description = "The number of periods over which data is compared to the specified threshold for max cpu metric alarm"
  default     = "3"
  type        = string
}

variable "min_cpu_evaluation_period" {
  description = "The number of periods over which data is compared to the specified threshold for min cpu metric alarm"
  default     = "3"
  type        = string
}

variable "max_cpu_period" {
  description = "The period in seconds over which the specified statistic is applied for max cpu metric alarm"
  default     = "60"
  type        = string
}

variable "min_cpu_period" {
  description = "The period in seconds over which the specified statistic is applied for min cpu metric alarm"
  default     = "60"
  type        = string
}
