#!/bin/bash

#############
## Delete any file with a file extension other than .md
#############
find $AWS_BACKUP ! -name "*.ogg" -type f -delete 

############
## Uploads all the files in the desired folder to the s3 bucket
############
aws s3 sync $AWS_BACKUP s3://$AWS_BUCKET --profile=$AWS_PROFILE

############
## Check the integrity of the files and create log files
############
source $AWS_SYNC
