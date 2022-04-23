resource "aws_ecs_cluster" "default" {
  name = "task3"
  tags = {
    Name = "task3"
  }
}

resource "aws_ecs_task_definition" "my_task_definition" {
  family                   = "frontend-task-definition"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  memory                   = "1024"
  cpu                      = "512"
  container_definitions    = <<EOF
[
  {
    "name": "fuzzy-guacamole-container",
    "image": "rfalcao/fuzzy-guacamole:latest",
    "memory": 1024,
    "cpu": 512,
    "essential": true,
    "portMappings": [
      {
        "containerPort": 8080
      }
    ]
  }
]
EOF

}

resource "aws_ecs_service" "my_ecs_service" {
  name            = "frontend-service"
  cluster         = aws_ecs_cluster.default.id
  task_definition = aws_ecs_task_definition.my_task_definition.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = [aws_security_group.ecs_sg.id]
    subnets          = [aws_subnet.private.id]
    assign_public_ip = true
  }


  load_balancer {
    target_group_arn = aws_alb_target_group.alb-tg.0.arn
    container_name   = "fuzzy-guacamole-container"
    container_port   = 8080
  }

  deployment_controller {
    type = "CODE_DEPLOY"
  }

  depends_on = [
    aws_alb_listener.alb-http-listener,
    aws_alb_target_group.alb-tg
  ]
}

resource "aws_security_group" "ecs_sg" {
  name        = "ecs-security-group"
  description = "allow inbound access from the ALB only"
  vpc_id      = aws_vpc.default.id

  ingress {
    protocol        = "tcp"
    from_port       = 0
    to_port         = 0
    security_groups = [aws_security_group.alb-sg.id]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}
