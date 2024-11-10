variable "ecs_cluster_arn" {
	description = "ARN do Cluster a ser Ativado."
	type = string
}

variable "ecs_task_arn" {
	description = "ARN da Task a ser Executada."
	type = string
}

variable "ecs_task_revision" {
	description = "Revisão da Task a ser Executada."
	type = string
}
