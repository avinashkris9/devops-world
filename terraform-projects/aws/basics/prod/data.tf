# Fetch latest AMI from AWS
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical owned ami
}

######################################
# Use the existing keypair
####################################
data "aws_key_pair" "mykeypair" {
  key_name = "aws_key_pair"
 
}

data "aws_security_group" "sg_ssh"{
    filter {
    name   = "group-name"
    values = ["default-ssh-access"]
  }
}

data "aws_instance" "devops_controller" {
  

  filter {
    name   = "tag:serverType"
    values = ["devops-controller"]
  }
}