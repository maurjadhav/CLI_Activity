#!/bin/bash

# ensure number of arguments passed are two
if [ $# -ne 3 ]; then
   echo "You have passed wrong arguments"
   echo "Pass the correct values in $0 as <tagName> <tagValue> <action>"
   exit 1
fi


tagName=$1
tagValue=$2
action=$3 


# get all active regions for my account

regions=$(aws ec2 describe-regions \
        --query "Regions[].RegionName" \
        --output text)

# loop through all regions
for region in $regions; do
    echo "Checking region ${region}"
    # get all ec2 instances with tag Env = Dev
    instance_ids=$(aws ec2 describe-instances \
        --filters "Name=tag:${tagName},Values=${tagValue}" \
        --query "Reservations[0].Instances[].InstanceId" \
        --output text\
        --region ${region})

    if [[  $instance_ids != "None" ]]; then
        echo "Following instances will be ${action}: ${instance_ids}"
        # stop all the instances
        aws ec2 ${action}-instances \
            --instance-ids $instance_ids \
            --region ${region} > /dev/null
    else
        echo "No instances found with tag ${tagName} = ${tagValue}"
    fi
done
