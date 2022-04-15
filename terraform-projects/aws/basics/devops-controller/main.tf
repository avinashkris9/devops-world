# Create a new ec2 instance

# Import modules from modules directory
# Required to load the SGs
module "bastion" {
  source = "./../modules"

}


######################################
# Create instance

####################################
resource "aws_instance" "controller" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  #availability_zone = var.az
  key_name               = data.aws_key_pair.mykeypair.key_name
  vpc_security_group_ids = [module.bastion.security_group_ssh]
  user_data              = <<EOF
#!/bin/bash
echo "Changing Hostname"
instance_name=$(curl -s http://169.254.169.254/latest/meta-data/hostname)
hostnamectl set-hostname --static $instance_name
apt update
apt install -y maven npm
add-apt-repository --yes --update ppa:ansible/ansible
apt install -y ansible

EOF
  tags = {
    Name = "${var.instance_names}" # This sets the instance name
    serverType= "devops-controller"
    componentType="ansible-controller"
  }


# # Remote is required to wait till connection is setup
# provisioner "remote-exec" {
#     inline = ["sudo apt update", "echo Done!"]

#     connection {
#       host        = self.ipv4_address
#       type        = "ssh"
#       user        = "root"
#       private_key = file(var.pvt_key)
#     }
#   }


# #Local Exec is run as soon as provisionng is completed (before actual initializing)
#   provisioner "local-exec" {
#     command ="ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i '${self.ipv4_address},' -e serverName=-i '${self.ipv4_address}  ../../../ansible-playbooks/setup-devops-controller.yml"
#   }
}




resource "aws_instance" "jenkins_host" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

availability_zone =aws_instance.controller.availability_zone
  #availability_zone = var.az
  key_name               = data.aws_key_pair.mykeypair.key_name
  vpc_security_group_ids = [module.bastion.security_group_ssh, module.bastion.security_group_http_8080]
  user_data              = <<EOF
#!/bin/bash
echo "Changing Hostname"
instance_name=jenkinsHost
hostnamectl set-hostname --static $instance_name


EOF
  tags = {
    Name = "jenkins" # This sets the instance name
    serverType= "devops-controller"
    componentType="jenkins-controller"
  }

}
######################################
# Display the public ip
####################################

output "controller_ip" {
  value = aws_instance.controller.public_ip

}

output "controller_private_ip" {
  value = aws_instance.controller.private_ip

}

output "controller_az" {
  value = aws_instance.controller.availability_zone 

}

output "jenkins_controller_ip" {
  value = aws_instance.jenkins_host.public_ip

}

output "jenkins_controller_private_ip" {
  value = aws_instance.jenkins_host.private_ip

}

output "jenkis_controller_az" {
  value = aws_instance.jenkins_host.availability_zone 

}
