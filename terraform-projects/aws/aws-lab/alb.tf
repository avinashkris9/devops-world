resource "aws_lb" "alb" {
  name               = "Web-ALB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg_alb_web.id]
  subnets            = [aws_subnet.public.id, aws_subnet.public_b.id]

  enable_deletion_protection = false

  

  tags = {
    Environment = "production"
  }
}


resource "aws_lb_target_group" "instance_target_group" {
  name     = "web-instance-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main_lab.id

}



output "lb_name"{
    value=aws_lb.alb.dns_name
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"


  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.instance_target_group.arn
  }
}

# resource "aws_lb_target_group_attachment" "alb_instance_target_group" {
#  target_group_arn = aws_lb_target_group.instance_target_group.arn
#   target_id        = aws_launch_template.launch_webserver_template.
# }