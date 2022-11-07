#!/bin/bash

echo -n "Provide an animal : "
read answer

while [[ $answer != [Cc]hickens ]]; do
  echo "Anser is incorrect"
  echo "Try Again"
  read answer
done

echo Congratulations: $answer is an animal.
