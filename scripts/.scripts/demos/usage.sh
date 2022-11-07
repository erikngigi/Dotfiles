#!/bin/bash

usage()
{
  script=$1
  shift

  echo "Usage: `basename $script` $*" 1>&2
  exit 2 
}

# test the above function
usage $0 filename username ...
