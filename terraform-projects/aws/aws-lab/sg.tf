resource "aws_security_group" "sg_http_8080" {
  name        = "default-http-8080-access"
  description = "Allow 8080 http"
    vpc_id = aws_vpc.main_lab.id

  ingress {
    description      = "8080 Http"
  from_port =0
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

 

  tags = {
    Name = "allow-8080"
  }
}

output "security_group_http_8080" {
    value = aws_security_group.sg_http_8080.id
}

resource "aws_security_group" "allow-ssh" {
  name        = "default-ssh-access"
  description = "Allow SSH inbound traffic"
    vpc_id = aws_vpc.main_lab.id


  ingress {
    description      = "SSH from public"
  from_port =0
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow-ssh"
  }
}

output "security_group_ssh" {
    value = aws_security_group.allow-ssh.id
}


