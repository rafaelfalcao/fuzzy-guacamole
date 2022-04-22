resource "aws_autoscaling_group" "asg" {
  name                 = "web-instance"
  launch_configuration = aws_launch_configuration.default.id
  availability_zones   = ["${data.aws_availability_zones.available.names[0]}"]
  load_balancers       = ["${aws_elb.elb.name}"]
  min_size             = 1
  max_size             = 3
  termination_policies = ["OldestInstance"]
  health_check_type = "ELB"
}

resource "aws_launch_configuration" "default" {
  image_id        = var.ami
  instance_type   = var.instance_type
  security_groups = ["${aws_security_group.ec2_secgrp.id}"]
  key_name        = "io"
  user_data       = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "ec2_secgrp" {
  name        = "web-instance-sg"
  description = "web instance sg"
  vpc_id      = aws_vpc.default.id

  ingress {
    description = "http from vpc"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "https from vpc"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ec2-web-sec-group"
  }
}
