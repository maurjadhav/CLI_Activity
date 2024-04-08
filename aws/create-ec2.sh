#!/bin/bash
#Creating the ec2 instance
aws ec2 run-instances \
   --image-id "ami-0e17b4db59f6aafcc" \
   --instance-type "t3.micro" \
   --key-name "id_rsa" \
   --security-group-ids "sg-0cbe452ae884d54ef"

aws ec2 describe-instances #--output text
