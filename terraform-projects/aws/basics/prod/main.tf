# Create a new ec2 instance

# Import modules from modules directory
# Required to load the SGs
module "prod" {
   source = "./../modules"
 
}


######################################
# Create instance

####################################
resource "aws_instance" "prod_ec2" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  count=1
  #availability_zone = var.az
 key_name=data.aws_key_pair.mykeypair.key_name
vpc_security_group_ids = [module.prod.security_group_ssh,module.prod.security_group_http_8080]
user_data = <<EOF
#!/bin/bash
echo "Changing Hostname"
instance_name=$(curl -s http://169.254.169.254/latest/meta-data/hostname)
sudo hostnamectl set-hostname --static $instance_name

EOF
  tags = {
 Name = "${var.instance_names}-${count.index+1}" # This sets the instance name
 serverType= "prod"
  }
}

######################################
# Display the public ip
####################################

output "prod_ec2_ip"{
     value = "${aws_instance.prod_ec2.*.public_ip}"
    
}
output "prod_ec2_tags"{
     value = "${aws_instance.prod_ec2.*.tags_all}"
    
}