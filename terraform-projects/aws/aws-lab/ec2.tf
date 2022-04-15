
# ######################################
# # Create instance

# ####################################
# resource "aws_instance" "my_webserver" {
#   ami           = data.aws_ami.myami.id
#   instance_type = "t2.micro"
# key_name = aws_key_pair.deployer.id

# subnet_id =aws_subnet.public.id
# user_data = file("./userdata.sh")
# #   user_data              = <<EOF
# # #!/bin/sh
# # yum -y install httpd php mysql php-mysql
# # chkconfig httpd on
# # systemctl start httpd
# # if [ ! -f /var/www/html/immersion-day-app.tar.gz ]; then
# #    cd /var/www/html
# #    wget https://aws-joozero.s3.ap-northeast-2.amazonaws.com/immersion-day-app.tar.gz
# #    tar xvfz immersion-day-app.tar.gz
# #    chown apache:root /var/www/html/rds.conf.php
# # fi
# # yum -y update

# # EOF
#   tags = {
#     Name = "${var.instance_names}" # This sets the instance name
#     Type="Web server for custom AMI"
#   }
# associate_public_ip_address=true
#  vpc_security_group_ids = [aws_security_group.allow-ssh.id,aws_security_group.sg_http_8080.id]
# }



# ######################################
# # Display the public ip
# ####################################

# output "controller_ip" {
#   value = aws_instance.my_webserver.public_ip

# }

# output "controller_private_ip" {
#   value = aws_instance.my_webserver.private_ip

# }

# output "controller_az" {
#   value = aws_instance.my_webserver.availability_zone 

# }