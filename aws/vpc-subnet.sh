#!/bin/bash

#Creating a vpc
aws ec2 create-vpc --cidr-block "192.168.0.0/16" \
    --tag-specifications "ResourceType=vpc,Tags=[{Key=Name,Value=Learning}]"

#"VpcId": "vpc-04c0e96c1827467de",

aws ec2 describe-vpcs --vpc-ids --output text