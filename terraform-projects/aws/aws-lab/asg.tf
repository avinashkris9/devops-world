resource "aws_autoscaling_group" "asg_webserver" {
  name                      = "Web-ASG"
   launch_template {
    id      = aws_launch_template.launch_webserver_template.id
    version = "$Latest"
  }

   vpc_zone_identifier = [aws_subnet.public.id, aws_subnet.public_b.id]
  desired_capacity   = 1
  max_size           = 1
  min_size           = 1


  
  target_group_arns=[ aws_lb_target_group.instance_target_group.id]
}

resource "aws_autoscaling_policy" "asg_webserver_policy"{
autoscaling_group_name =aws_autoscaling_group.asg_webserver.name
policy_type ="TargetTrackingScaling"
name="asg_webserver-targetTracking"
  target_tracking_configuration {


 target_value = 40.0
 predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
  }
}