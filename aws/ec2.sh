#!/bin/bash

# ensure number of arguments passed are two
if [ $# -ne 5 ]; then
   echo "You have passed wrong arguments"
   echo "Pass the correct values in  $0 as  <image_id> <key_name> <count> <region> <action>"
   exit 1
fi


image_id=$1
instance_type="t2.micro"
key_name=$2
count=$3
region=$4
action=$5


if [ $action != "create" ]; then
    echo "As of now only create actions are supported"
    exit 1
fi

if [ $action == "create" ]; then
    # create ec2
    echo "Your ec2 create in the default region : ${region}"

    aws ec2 run-instances \
        --image-id ${image_id} \
        --instance-type ${instance_type} \
        --key-name ${key_name} \
        --count ${count} \
        --region ${region} \
        --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=Learning},{Key=CreatedBy,Value=cli}]"
fi

# get all instances matching tag CreatedBy=cli 
    InstanceId=$(aws ec2 describe-instances \
        --filters "Name=tag:CreatedBy,Values=cli" \
        --region ${region} \
        --query "Reservations[].Instances[].InstanceId" \
        --output text)
    echo "Created instances are : ${InstanceId}"






#aws ec2 run-instances \
#        --image-id "ami-0e17b4db59f6aafcc" \
#        --instance-type "t3.micro" \
#        --key-name "id_rsa" \
#        --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=Learning},{Key=CreatedBy,Value=cli}]"


#aws ec2  terminate-instances --instance-ids "i-0234e9b72dce9809b"       "i-02ce43e87093fb1ca"     "i-038e54c41a590a87a"     "i-075aed6d876d617d7"     "i-0552c9cfa3c5dd641"     "i-06aa19339ca0e788d"
