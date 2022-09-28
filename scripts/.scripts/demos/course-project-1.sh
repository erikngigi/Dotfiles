#!/bin/bash
# Stores clients details in a text file

fname="$HOME/names.txt"

#Message
echo "Please enter the following details"
echo

# User's First Name
echo -n "Enter your First Name : "
read firstname

# User's Surname
echo -n "Enter your Surname : "
read surname

# User's Address
echo -n "Enter your address : "
read address

#User's city
echo -n "Enter your City : "
read city

#User's Zip Code
echo -n "Enter your Zip Code : "
read zip_code

echo $firstname:$surname:$address:$city:$zip_code >> $fname

#Show details in the file

(
echo #Line jump
echo "Current contacts in the database"
echo
cat $fname
) | more --squeeze

# Display number of contacts

echo
echo "There are `cat $fname | wc -l` contacts in the database"
