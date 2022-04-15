resource "aws_launch_template" "launch_webserver_template" {
  name = "my-webserver-launch-template"
  instance_type = "t2.micro"
  image_id           = data.aws_ami.myami.id

key_name = aws_key_pair.deployer.id


vpc_security_group_ids = [ aws_security_group.sg_asg_alb.id ]


   user_data = filebase64("${path.module}/userdata.sh")

tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "my-webserver-lt-instance"
    }
  }


}