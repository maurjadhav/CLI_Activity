#!/bin/bash

# ensure number of arguments passed are two
if [ $# -ne 2 ]; then
   echo "You have passed wrong arguments"
   echo "Pass the correct values in  $0 as <region> <action>"
   exit 1
fi

Region=$1
Action=$2

if [ $Action != "create" ] && [ $Action != "delete" ]; then
    echo "As of now only create and delete actions are supported"
    exit 1
fi


if [ $Action == "create" ]; then
    # create vpc
    echo "Your Vpc create in the region : ${Region}"

    vpc_id=$(aws ec2 create-vpc --cidr-block "192.168.0.0/16" \
        --tag-specifications "ResourceType=vpc,Tags=[{Key=Name,Value=Learning},{Key=CreatedBy,Value=cli}]" \
        --query "Vpc.VpcId" \
        --region ${Region} \
        --output text)
    echo "Vpc Id is : ${vpc_id}"

    # create subnet
    Web1_subnet=$(aws ec2 create-subnet \
        --vpc-id ${vpc_id} \
        --cidr-block "192.168.0.0/24" \
        --availability-zone "${Region}a" \
        --tag-specifications "ResourceType=subnet,Tags=[{Key=Name,Value=Web-1},{Key=CreatedBy,Value=cli}]" \
        --query "Subnet.SubnetId" \
        --region ${Region} \
        --output text)
    echo "Web1 Subnet Id is : ${Web1_subnet}"
    echo "Your Web1 Subnet created in : ${Region}a"


    Web2_subnet=$(aws ec2 create-subnet \
        --vpc-id ${vpc_id} \
        --cidr-block "192.168.1.0/24" \
        --availability-zone "${Region}b" \
        --tag-specifications "ResourceType=subnet,Tags=[{Key=Name,Value=Web-2},{Key=CreatedBy,Value=cli}]" \
        --query "Subnet.SubnetId" \
        --region ${Region} \
        --output text)
    echo "Web2 Subnet Id is : ${Web2_subnet}"
    echo "Your Web1 Subnet created in : ${Region}b"


    Data1_subnet=$(aws ec2 create-subnet \
        --vpc-id ${vpc_id} \
        --cidr-block "192.168.2.0/24" \
        --availability-zone "${Region}c" \
        --tag-specifications "ResourceType=subnet,Tags=[{Key=Name,Value=Data-1},{Key=CreatedBy,Value=cli}]" \
        --query "Subnet.SubnetId" \
        --region ${Region} \
        --output text)
    echo "Data1 Subnet Id is : ${Data1_subnet}"
    echo "Your Data1 Subnet created in : ${Region}c"


    Data2_subnet=$(aws ec2 create-subnet \
        --vpc-id  ${vpc_id} \
        --cidr-block "192.168.3.0/24" \
        --availability-zone "${Region}a" \
        --tag-specifications "ResourceType=subnet,Tags=[{Key=Name,Value=Data-2},{Key=CreatedBy,Value=cli}]" \
        --query "Subnet.SubnetId" \
        --region ${Region} \
        --output text)
    echo "Web2 Subnet Id is : ${Data2_subnet}"
    echo "Your Data2 Subnet created in : ${Region}a"

    elif [ $Action == "delete" ]; then
    # get all subnets matching tag CreatedBy=cli 
    subnets=$(aws ec2 describe-subnets \
        --region "${Region}" \
        --filters "Name=tag:CreatedBy,Values=cli" \
        --query "Subnets[].SubnetId" \
        --output text)

    echo "Deleting Subnets in the vpc"

    for subnet in ${subnets}; do
        aws ec2 delete-subnet \
            --subnet-id "${subnet}" \
            --region "${Region}"
        echo "subnets are : ${subnet}"
    done

    # get all vpcs
    vpcs=$(aws ec2 describe-vpcs \
        --region "${Region}" \
        --filters "Name=tag:CreatedBy,Values=cli" \
        --query "Vpcs[].VpcId" --output text)

    echo "Deleting vpc"
    
    for vpc in ${vpcs}; do
        aws ec2 delete-vpc \
            --vpc-id "${vpc}" \
            --region "${Region}"
        echo "vpc is : ${vpc}"
    done
fi