#!/bin/bash

echo -n "Enter a Command : "
read command

$command | while read user term time
do
  echo $user has been on $term since $time
done
