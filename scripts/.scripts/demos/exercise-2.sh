#!/bin/bash

#
# Users in the System
#

echo -n "Number of possible users on the system : "
cat /etc/passwd | wc -l

#
# User logged in
#
echo -n "Number of users logged onto the system : "
who | wc -l

#
# Processes running
#

echo -n "Total Number of Processes Running : "
ps -e | wc -l
