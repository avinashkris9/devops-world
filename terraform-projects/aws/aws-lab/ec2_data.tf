# Fetch latest AMI from AWS
data "aws_ami" "myami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-2.0.20220316.0-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["137112412989"] # Canonical owned ami
}

# ######################################
# # Use the existing keypair
# ####################################
# data "aws_key_pair" "mykeypair" {
#   key_name = "aws_key_pair"

# }
