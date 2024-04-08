#!/bin/bash

#Creating a vpc
vpc_id=$(aws ec2 create-vpc --cidr-block "192.168.0.0/16" \
    --tag-specifications "ResourceType=vpc,Tags=[{Key=Name,Value=Learning}]" \
    --query "Vpc.VpcId" \
    --output text)
echo "Vpc Id is : ${vpc_id}"


#Create subnet
Web1_subnet=$(aws ec2 create-subnet \
    --vpc-id ${vpc_id} \
    --cidr-block "192.168.0.0/24" \
    --availability-zone "ap-south-2a" \
    --tag-specifications "ResourceType=subnet,Tags=[{Key=Name,Value=Web-1}]" \
    --query "Subnet.SubnetId" \
    --output text)
echo "Web1 Subnet Id is : ${Web1_subnet}"


Web2_subnet=$(aws ec2 create-subnet \
    --vpc-id ${vpc_id} \
    --cidr-block "192.168.1.0/24" \
    --availability-zone "ap-south-2a" \
    --tag-specifications "ResourceType=subnet,Tags=[{Key=Name,Value=Web-2}]" \
    --query "Subnet.SubnetId" \
    --output text)
echo "Web2 Subnet Id is : ${Web2_subnet}"


Data1_subnet=$(aws ec2 create-subnet \
    --vpc-id ${vpc_id} \
    --cidr-block "192.168.2.0/24" \
    --availability-zone "ap-south-2c" \
    --tag-specifications "ResourceType=subnet,Tags=[{Key=Name,Value=Data-1}]" \
    --query "Subnet.SubnetId" \
    --output text)
echo "Web2 Subnet Id is : ${Data1_subnet}"


Data2_subnet=$(aws ec2 create-subnet \
    --vpc-id  ${vpc_id} \
    --cidr-block "192.168.3.0/24" \
    --availability-zone "ap-south-2a" \
    --tag-specifications "ResourceType=subnet,Tags=[{Key=Name,Value=Data-2}]" \
    --query "Subnet.SubnetId" \
    --output text)
echo "Web2 Subnet Id is : ${Data2_subnet}"