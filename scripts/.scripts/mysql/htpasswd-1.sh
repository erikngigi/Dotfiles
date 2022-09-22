#!/bin/bash

# Set the htpasswd file
htpasswd="/tmp/.htpasswd"

echo "Enter the Username for the new htpasswd user:"
  read user
  # Check to see if the user exists in htpasswd already
  if [[ $(cat $htpasswd) == *"$user"* ]];then
    read -s "This user already exists, would you like to update their password (y/n)?" yn
    case $yn in
        # If yes, continue. Else, exit
        [Yy]* ) :;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
  else
    :
  fi
echo "Now the password (Less than 8 characters)?"
  read pass
    if [[ ${#pass} -ge 9 ]];then
      echo "Please enter a password less than 8 characters"
      read pass
    else
      :
    fi

# Create the User
echo "Now creating the User"
# Delete the user if they exist in the file (User has confirmed)
sed -i "/^$user\:/d" $htpasswd
echo "$user:$(openssl passwd -crypt $pass)\n" >> $htpasswd
