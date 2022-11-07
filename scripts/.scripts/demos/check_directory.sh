#!/bin/bash
# Check if directory exist

echo -n "Enter the name of a directory : "
read dname

if [ -z "$dname" ] # -z checks if the lenght of the string is 0
then
  echo "You did not enter a valid directory"
elif
  [ -d $dname -a -w $dname ]  # -d checks if the directory exist 
                              # -a if expression1 and expression2 are true
                              # -w if the file exist and user has write access
then
  echo "Well done" > $dname/hello
else
  echo "$dname is not a writtable directory. Nothin has been written"
fi

