resource "aws_scheduler_schedule" "event_bridge" {
  name        = "schedule-batch"
  group_name  = "default"

  flexible_time_window {
    mode = "OFF"
  }

  schedule_expression = "cron(*/30 * * * ? *)" # run every 30 minutes

  target {
    arn      = var.ecs_cluster_arn 
    role_arn = "arn:aws:iam::038160823904:role/LabRole"

    ecs_parameters {
      task_definition_arn = trimsuffix(var.ecs_task_arn, ":${var.ecs_task_revision}")
      launch_type         = "FARGATE"
    }

    retry_policy {
      maximum_event_age_in_seconds = 300
      maximum_retry_attempts       = 10
    }
  }
}
