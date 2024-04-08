#!/bin/bash

#Creating a vpc
aws ec2 create-vpc --cidr-block "192.168.0.0/16" \
    --tag-specifications "ResourceType=vpc,Tags=[{Key=Name,Value=Learning}]"

#"VpcId": "vpc-04c0e96c1827467de",  vpc-01c6d889cc209bb81 

aws ec2 describe-vpcs --vpc-ids --output text

#Create subnet
aws ec2 create-subnet \
    --vpc-id "vpc-04c0e96c1827467de" \
    --cidr-block "192.168.0.0/24" \
    --availability-zone "ap-south-2a" \
    --tag-specifications "ResourceType=subnet,Tags=[{Key=Name,Value=Web-1}]"

 #"SubnetId": "subnet-01ba3b8cb67a5f7fc",

 aws ec2 create-subnet \
    --vpc-id "vpc-04c0e96c1827467de" \
    --cidr-block "192.168.1.0/24" \
    --availability-zone "ap-south-2a" \
    --tag-specifications "ResourceType=subnet,Tags=[{Key=Name,Value=Web-2}]"


#"SubnetId": "subnet-05ec55413ff1d3b99",

 aws ec2 create-subnet \
    --vpc-id " vpc-01c6d889cc209bb81 " \
    --cidr-block "10.0.0.0/24" \
    --availability-zone "ap-south-2c" \
    --tag-specifications "ResourceType=subnet,Tags=[{Key=Name,Value=Data-1}]"

# "SubnetId": "subnet-0aac979f07c24c5b1",
 aws ec2 create-subnet \
    --vpc-id " vpc-01c6d889cc209bb81 " \
    --cidr-block "10.0.1.0/24" \
    --availability-zone "ap-south-2a" \
    --tag-specifications "ResourceType=subnet,Tags=[{Key=Name,Value=Data-2}]"

#"SubnetId": "subnet-0a50a272566f8387a",