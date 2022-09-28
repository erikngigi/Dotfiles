#!/bin/bash
#sum of the numbers

no1=87879787
no2=56456456456
no3=545645645645

result=$[ no3 + no1 - no2 ]

echo Sum of:$result

echo "obase=10;$no2" | bc
