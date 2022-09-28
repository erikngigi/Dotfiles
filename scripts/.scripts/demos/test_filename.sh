#!/bin/bash

echo -n "Enter a Filename : "
read fname

if [ -z "$fname" ]
then
  echo "You did not enter a valid filename"
elif
   [ -f "$fname" -a -w "$fname" ]
then
  echo "Everything is okay"
else
  echo "The file is not writtable"
fi
