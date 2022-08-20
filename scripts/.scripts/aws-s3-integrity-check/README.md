# aws-s3-integrity-check

Bash script to check the integrity of a set of local files uploaded into an AWS S3 bucket.

## Prerequisites

1. Connect to your AWS account. For this purpouse, you may want to use **aws configure** command in your Linux terminal. This command is interactive, so the AWS CLI will prompt you to enter additional information.

   **IMPORTANT:** for the correct operation of this *aws_check_integrity.sh* script, **json** must be chosen as the preferred output format during the **aws configure** command execution.

```sh
> aws configure 

AWS Access Key ID [None]: your_AWS_access_key_ID 
AWS Secret Access Key [None]: your_AWS_secret_access_key 
Default region name [None]: your_default_region_name 
Default output format [None]: json 
```

2. Synchronize your local folder with your AWS bucket. For this purpouse, you may want to use the AWS CLI **sync** command as follows (we'll made use from the example below later in this file):

```sh
> aws s3 sync /data/nucCyt/raw_data s3://nuccyt 
```

## Description

Considering that your local directory path structure is the same one than the existing on our S3 bucket (please, check the 'Prerequisites' section above) **aws_check_integrity.sh** script will:

1. Loop through the set of files within your local directory.

2. Per each file found in your local folder, the script will check its size (in case the object found is a directory, it will just continue looping through its files):

   * If the file size is smaller than 8MG, it will generate a simple MD5 digest value.

3. Retrieve the ETag value from the same file stored on the S3 bucket.

4. Compare the retrieved ETag value with the one the script has just generated.

   * If both ETag numbers are equals, the script will confirm the integrity of the file stored on the S3 bucket. Otherwise, the script will generate an error. In any case, the result will be stored within a log file which name will follow the pattern: S3_integrity_log.timestamp_bucketname.txt. The log file will be stored within a folder called 'logs', which the script will automatically create in the current path in case it doesn't exist yet.


## Usage

1. Grant execution access to he s3md5 script file.
```sh
> chmod 755 ./s3md5/s3md5
```
```
2. The *aws-s3-integrity-check* folder should look similar to the following:
```sh
total 16
-rw-r--r-- 1 your_user your_group 3573 date README.md
-rwxr-xr-x 1 your_user your_group 3301 date aws_check_integrity.sh
drwxr-xr-x 2 your_user your_group 4096 date s3md5
```
6. Execute the script 'aws_check_integrity.sh' following the instructions below:
```
Usage : aws_check_integrity.sh <local_path> <bucket_name> <bucket_folder>

- local_path: local path of our server where all previously uploaded files are currently stored. For example: /data/nucCyt/raw_data/. 

- bucket_name: the name of the S3 bucket we want to check. For example: nuccyt. 

- bucket_folder: the name of the root folder on the S3 bucket. For example: raw_data/. If there is not any folder in the root, this parameter will be a slash (/) indicating the root path. 
```


## Example

```sh
> aws_check_integrity.sh /data/nucCyt/raw_data/ nuccyt raw_data/
```
