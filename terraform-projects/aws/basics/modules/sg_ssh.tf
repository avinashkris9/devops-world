resource "aws_security_group" "allow-ssh" {
  name        = "default-ssh-access"
  description = "Allow SSH inbound traffic"


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