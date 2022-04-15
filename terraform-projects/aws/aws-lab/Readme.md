# AWS Lab


1. Create a VPC
2. Create 4 subnets, public & private on 2 AZs
3. An internet gateway for public subnets
4. Add internet gateway to a new route table on public subnet
5. An ALB exposed to internet
6. A launch template to create ec2
7. An Auto Scaling  Group for the LT & ALB
8. Security Groups for everything!


- Nat gateway is required for making instances private and expose to ALB. Since it is not with free tier, the instances are made public.