#!/bin/bash

process_sig()
{
  echo
  date
  cal
}

trap process_sig 10

while :
do
  sleep 2
done
