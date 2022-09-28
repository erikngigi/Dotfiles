#!/bin/bash

#Ask user to enter database name and save input to dbname variable
read -p "Enter Database Name : " dbname

#checking if database exist
mysql -Bse "USE $dbname" 2> /dev/null

#if database exist:
if [ $? -eq 0 ]; then

#ask user about username
read -p "Enter the username you wish to create : " username

#ask user about allowed hostname
read -p "Enter Host To Allow Access Eg: %,ip or hostname : " host

#ask user about password
read -p "Enter the Password for New User ($username) : " password

#mysql query that will create new user, grant privileges on database with entered password
query="GRANT ALL PRIVILEGES ON $dbname.* TO $username@'$host' IDENTIFIED BY '$password'";

#ask user to confirm all entered data
read -p "Executing Query : $query , Please Confirm (y/n) : " confirm

#if user confims then
if [ "$confirm" == 'y' ]; then

#run query
mysql -e "$query"

#update privileges, without this new user will be created but not active
mysql -e "flush privileges"

else

#if user didn't confirm entered data
read -p "Aborted, Press any key to continue.."

#just exit
fi

else

#If database not exit – warn user and exit
echo "The Database: $dbname does not exist, please specify a database that exists";

fi

echo "$username" >> "/tmp/password.txt"
