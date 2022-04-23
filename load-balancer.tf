resource "aws_alb" "app-load-balancer" {
  name               = "alb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.alb-sg.id}"]
  subnets            = [aws_subnet.private.id, aws_subnet.private_1.id]

  tags = {
    Name = "alb"
  }
}

locals {
  target_groups = [
    "green",
    "blue",
  ]
}

resource "aws_alb_target_group" "alb-tg" {
  count = length(local.target_groups)

  name = "tg-${element(local.target_groups, count.index)}"

  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.default.id
  target_type = "ip"

  health_check {
    path = "/"
    port = 80
  }
}

resource "aws_alb_listener" "alb-http-listener" {
  load_balancer_arn = aws_alb.app-load-balancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.alb-tg.*.arn[0]
  }
}

resource "aws_alb_listener_rule" "alb-listener-rule" {
  listener_arn = aws_alb_listener.alb-http-listener.arn

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.alb-tg.*.arn[0]
  }

  condition {
    host_header {
      values = [var.domain_name]
    }
  }
}

resource "aws_security_group" "alb-sg" {
  name   = "alb-allow-http-sg"
  vpc_id = aws_vpc.default.id

  ingress {
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow-http-sg"
  }
}