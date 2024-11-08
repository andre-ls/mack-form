resource "aws_ecs_task_definition" "ecs_task" {
	 family                   = "ecs_task"
	 requires_compatibilities = ["FARGATE"]
	 cpu                      = 512
	 memory                   = 1024
	 network_mode             = "awsvpc"
         container_definitions = jsonencode([
		{
		  name      = "batch_task"
		  image     = "busybox"
		  command = ["ls"]
		  cpu       = 10
		  memory    = 512
		  essential = true
		  portMappings = [
			{
			  containerPort = 80
			  hostPort      = 80
			}
		  ]
		}
    ])
}
