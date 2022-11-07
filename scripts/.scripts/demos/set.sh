#!/bin/bash

if [ $# = 0 ]
then
  set -- `who | grep eric`
fi

echo $1 is logged in on $2 since $3
shift 1
echo since $*
