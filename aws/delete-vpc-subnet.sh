#!/bin/bash
#delete vpc
aws ec2  delete-vpc --vpc-id "<vpc-id>"

#before deleteing the vpc you have to delete the subnet present in that vpc
aws ec2 delete-subnet --subnet-id "<subnet-id>"
