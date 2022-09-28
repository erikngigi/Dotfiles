#!/bin/bash
#user enter their details such as name, address and phone number
#
#User Name
#

echo -n "Enter Your Name : "
read name
echo Name: $name > details.out

#
# User Address
#

echo -n "Enter Your Address : "
read address
echo Address: $address >> details.out

#
# User Number
#

echo -n "Enter Your Phone Number : "
read phone_number
echo Phone_Number: $phone_number >> details.out

#
# Final Message
#

echo Thank You. Your details have been saved in the file \"details.out\"
