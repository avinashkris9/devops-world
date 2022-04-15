resource "aws_security_group" "sg_alb_web" {
  name        = "alb-access"
  description = "Allow ALB public access"
    vpc_id = aws_vpc.main_lab.id


  ingress {
    description      = "HTTP From Public"
  from_port =0
    to_port          = 80
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
    Name = "allow-public-http-access"
  }
}