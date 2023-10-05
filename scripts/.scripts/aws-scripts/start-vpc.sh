#!/bin/bash

# Define variables
vpc_cidr="10.0.0.0/16"
subnet_cidrs=("10.0.1.0/24" "10.0.2.0/24" "10.0.3.0/24" "10.0.4.0/24")
subnet_names=("subnet-1" "subnet-2" "subnet-3" "subnet-4")
instance_count=20

# Create VPC
echo "Creating VPC..."
vpc_id=$(aws ec2 create-vpc --cidr-block $vpc_cidr --query 'Vpc.VpcId' --output text)
aws ec2 create-tags --resources $vpc_id --tags Key=Name,Value=MyVPC

# Enable DNS support and DNS hostnames in the VPC
aws ec2 modify-vpc-attribute --vpc-id $vpc_id --enable-dns-support "{\"Value\":true}"
aws ec2 modify-vpc-attribute --vpc-id $vpc_id --enable-dns-hostnames "{\"Value\":true}"

# Create subnets
for ((i=0; i<${#subnet_cidrs[@]}; i++)); do
  echo "Creating Subnet ${subnet_names[i]}..."
  subnet_id=$(aws ec2 create-subnet --vpc-id $vpc_id --cidr-block ${subnet_cidrs[i]} --availability-zone us-east-1a --query 'Subnet.SubnetId' --output text)
  aws ec2 create-tags --resources $subnet_id --tags Key=Name,Value=${subnet_names[i]}
done

# Create instances (assuming EC2 instances with your desired specifications)
for ((i=1; i<=${instance_count}; i++)); do
  echo "Creating EC2 instance $i..."
  aws ec2 run-instances --image-id <your-image-id> --subnet-id <your-subnet-id> --instance-type <your-instance-type> --key-name <your-key-pair> --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=Instance'$i'}]'
done

echo "VPC, subnets, and instances created successfully!"
