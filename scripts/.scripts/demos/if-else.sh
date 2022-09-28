#!/bin/bash

fname1="$HOME/names.txt"
fname2="$HOME/youtube.txt"

if diff $fname1 $fname2 > /dev/null
then
  echo "The files are the same"
else
  echo "The files are different"
  echo "Review the changes"
  diff $fname1 $fname2
fi
