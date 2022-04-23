resource "aws_instance" "task2_instance" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.private.id
  key_name                    = aws_key_pair.generated_key.key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.ec2-ssh.id]

  user_data = <<-EOF
        #!/bin/bash
        sudo yum update -y
        yum install python -y
        wget https://bootstrap.pypa.io/get-pip.py
        python get-pip.py
        pip install boto3
        sudo apt-get update
        sudo apt-get install awscli -y
    EOF
  #-y argument overrides the y/n question of apt-get
}

resource "aws_security_group" "ec2-ssh" {
  vpc_id      = aws_vpc.default.id
  name        = "allow-ssh"
  description = "security group that allows ssh and all egress traffic"
  egress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow-ssh-sg"
  }
}

resource "tls_private_key" "pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = var.key_name
  public_key = tls_private_key.pk.public_key_openssh

  provisioner "local-exec" {
    command = "echo '${tls_private_key.pk.private_key_pem}' > ~/.ssh/${var.key_name}.pem"
  }
}

output "instance_ip" {
  description = "The public ip for ssh access"
  value       = aws_instance.task2_instance.public_ip
}
