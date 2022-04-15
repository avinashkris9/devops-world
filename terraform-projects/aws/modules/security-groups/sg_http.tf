resource "aws_security_group" "sg_http_8080" {
  name        = "default-http-8080-access"
  description = "Allow 8080 http"


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