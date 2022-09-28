#!/bin/bash

declare -A shopping_list

shopping_list=([bread]='$40' [milk]='$20' [meat]='$25')

echo "Cots of bread is ${shopping_list[bread]} and milk is ${shopping_list[milk]}"
