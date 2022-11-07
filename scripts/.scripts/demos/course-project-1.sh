#!/bin/bash
# Stores clients details in a text file

fname="$HOME/names.txt"

# Check if the file exist
[ ! -f $fname ] && > $fname

# Forever loop
while true
do

  # Display Menu
  clear
  echo "SHELL PROGRAMMING DATABASE"
  echo "MAIN MENU"
  echo "What do you wish to do?"
  echo "1. Create a Record"
  echo "2. View a Record"
  echo "3. Search for a Record"
  echo "4. Delete a Record"
  echo

  # Prompt an Answer
  echo -n "Answer (or 'q' to quit) ? "
  read ans1 ans2

  # Empty Answer
  [ -z "$ans1" ] && continue

  # What to do

  case "$ans1" in
    1)
      # Read details entered via keyboard

      echo "Enter the contact details : "
      echo
      echo -n "First Name : "
      read name
      echo -n "Surname : "
      read surname
      echo -n "Address : "
      read address
      echo -n "City : "
      read city
      echo -n "State : "
      read state
      echo -n "Zip Code : "
      read zip_code

      # Write details to file

      echo $name:$surname:$address:$city:$state:$zip_code >> $fname
      ;;

    2)
      # Display cotacts in the text file
      (
      echo #skip line
      echo "Contacts already in the text file : "
      cat $fname
      ) | more --squeeze
    
      (
      # Count contacts in the file
      echo "Contacts in the database"
      echo
      echo "First Name       Surname       Address       City       State       Zip"
      echo =============================================================================
      # use awk for formating
      # The -F cause awk to receive fields as being separated by colons
      # "%-14.14s" means display a string in a field width of 14 left-justified

      sort -t : +1 $fname | awk -F : '{printf("%-14.14s%-16.16s%-20.20s%-15.15s%-6.6s%-5.5s\n", $1, $2, $3, $4, $5, $6)}'
      ) | more --squeeze
      ;;

    3) # Search for contact in the database
      echo "Search is not yet implemented"
      ;;

    4) # Delete contact in the database
      echo "Delete is not yet implemented"
      ;;

    q*|Q*)
      exit 0
      ;;

    *) #Invalid Option
      echo "The following option is invalid"
      ;;
  esac

  # User can see input
  echo -n "Hit <ENTER> to continue : "
  read ans2
done
