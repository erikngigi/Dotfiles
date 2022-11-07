#!/bin/bash

file="/etc/passwd"

pause ()
{
  echo -n "Hit Enter to continue"
  read junk
}

# grep lines that start with T
grep '^T' $file
pause

echo ============================================

# grep blank lines
grep '^$' $file
pause 
echo ============================================

# grep lines with two or more 'a's 
grep 'aa' $file
pause
echo ============================================

#grep lines with two or more digits
grep '[0-9][0-9]' $file
pause
echo ============================================

# grep lines that have the pattern [x,y] in them, where x and y are any numbers
grep -E '\[[0-9]+,[0-9]+\]' $file
pause
echo ============================================
