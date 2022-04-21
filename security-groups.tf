resource "aws_security_group" "allow_http" {
  name = "allow_http"
  description = "allow http ingress traffic"

  ingress {
      description = "http from vpc"
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = [ "0.0.0.0/0" ]
  }
  ingress {
      description = "ssh mfrom vpc"
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = [ "0.0.0.0/0" ] #TODO change this to home IP address
  }

  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = [ "0.0.0.0/0" ]
  }

  tags ={
      Name = "ec2-web-sec-group"
  }
}