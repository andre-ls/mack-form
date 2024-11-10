output "ecs_task_arn" {
   value = aws_ecs_task_definition.ecs_task.arn
}

output "ecs_task_revision" {
   value = aws_ecs_task_definition.ecs_task.revision
}

output "ecs_cluster_arn" {
   value = aws_ecs_cluster.ecs_cluster.arn
}
