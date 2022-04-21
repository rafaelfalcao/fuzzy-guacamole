resource "aws_instance" "web_instance" {
    availability_zone = "eu-west-2a"
    ami = "ami-0447a12f28fddb066"
    instance_type = "t2.micro"
    security_groups = [ "allow_http" ]

    user_data = <<-EOF
            #!/bin/bash
            sudo yum update -y
            sudo yum install httpd -y
            sudo service httpd start
            sudo chkconfig httpd on
            echo "<html><h1>Your terraform deployment worked !!!</h1></html>" | sudo tee /var/www/html/index.html
            hostname -f >> /var/www/html/index.html
            EOF


    connection {
      type = "ssh"
      user = "ec2-user"
      private_key = tls_private_key.default.private_key_pem
      host = aws_instance.web_instance.public_ip
    }
}

output "instance_ip" {
    value = aws_instance.web_instance.public_ip
}