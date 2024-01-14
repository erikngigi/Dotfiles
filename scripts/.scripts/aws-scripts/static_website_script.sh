#!/bin/bash

# setup variables
bucket_name="static-website-3363"
profile="aws-lab"
region="us-east-1"

aws s3 mb s3://$bucket_name --profile=$profile --region=$region
