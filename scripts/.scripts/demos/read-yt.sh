#!/bin/bash
#read the 1st and 2nd row of the youtube.txt 

exec < /home/eric/youtube.txt
read row1
echo -n "This is the first row: "
echo $row1
echo -n "This is the second row: "
read row2
echo $row2
echo -n "This is the third row: "
read row3
echo $row3
