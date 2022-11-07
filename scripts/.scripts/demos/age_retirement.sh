#!/bin/bash
# Prompts the age of the user 

retirement_age=45

echo -n "Enter your age : "
read age

if [ -z "$age" ]
then
  echo "You did not enter an age"
elif
  [ $age -gt $retirement_age ]
then
  echo "You Should be Retired"
else
  echo "You are still young"
fi
