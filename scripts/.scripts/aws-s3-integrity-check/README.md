# aws-s3-upload-log

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

## Description

Considering that your local directory path structure is the same one than the existing on our S3 bucket (please, check the 'Prerequisites' section above) **aws_check_integrity.sh** script will:

1. Loop through the set of files within your local directory.

2. Per each file found in your local folder, the script will check its size (in case the object found is a directory, it will just continue looping through its files):

   * If the file size is smaller than 8MG, it will generate a simple MD5 digest value.

   * If the file size is bigger than 8MG, it will make a request to a [s3md5](https://github.com/antespi/s3md5) function (author: [Antonio Espinosa](https://github.com/antespi)) which will apply the same algorithm as AWS does: it will split the file into 8MG little parts, generate the MD5 hash of each little part and generate the final MD5 digest number from the set of individual MD5 hashes.

3. Retrieve the ETag value from the same file stored on the S3 bucket.

4. Compare the retrieved ETag value with the one the script has just generated.

   * If both ETag numbers are equals, the script will confirm the integrity of the file stored on the S3 bucket. Otherwise, the script will generate an error. In any case, the result will be stored within a log file which name will follow the pattern: S3_integrity_log.timestamp_bucketname.txt. The log file will be stored within a folder called 'logs', which the script will automatically create in the current path in case it doesn't exist yet.


## Usage

Export the following environmental variables to either your `.bashrc` or `.zshrc` file to ensure that aws cli works with the local profile. 

1. Ensure you have set the correct profile name. Check `$HOME/.aws.config` for the profile name.

Display the profile name
``````
cat .aws/config
``````

Export the profile name. 
``````
export AWS_PROFILE='default'
``````
2. Export the `aws-check-status.sh` script
``````
export AWS_STATUS=$HOME/{local path to the script}  
``````
+ Example: `export AWS_STATUS=$HOME/.scripts/aws-s3-scripts/aws-check-status.sh`

3. Export the `aws s3 synchronized folder`

``````
export AWS_BACKUP=$HOME/{path to the folder}
``````

+ Example: `export AWS_BACKUP=$HOME/Git/Development/Clients/ctgreno/05-09-2022/uploads/`

4. Add the name of the s3 bucket.

``````
export AWS_BUCKET='name-of-the-bucket'
``````
+ Example: `export AWS_BUCKET='ericngigi-test'`

``````
export AWS_SYNC="$AWS_STATUS $AWS_BACKUP $AWS_BUCKET /"
``````

6. Add the path of where the logs will be stored. 

``````
export AWS_LOGS=$HOME/{local path to where the logs will be saved}
``````

+ Example: `export AWS_LOGS=$HOME/Git/Development/Clients/ctgreno/05-09-2022/logs/upload-log`

  - `upload-log` generic name tag for each log file. The user can change it to whatever they want. 

7. After making the changes ensure that you source your `bashrc` or `zshrc` file

+ For bash shell
``````
source .bashrc
``````
+ For zsh shell
``````
source .zshrc
``````
---

### Example

```sh
> aws-s3-upload-log.sh
```

## Supported platforms

This script has been successfully tested on:

* ArchLinux 51.15.64-1 LTS

## AUTHOR

Copyright (C) 2022<br />
[Eric Ngigi](https://github.com/EricNgigi)<br />
Email : ericmosesngigi@gmail.com<br />
Web   : [EricNgigi](https://erikngigi.github.io)

