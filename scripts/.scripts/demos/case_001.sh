#!/bin/bash

echo -n "Enter your favourite Rock Band of the 21st Century : "
read rock_name

case $rock_name in
  "Linkin Park")
    no_albums=7
    last_album="Living Things"
    ;;
  "Green Day")
    no_albums=8
    last_album="American Idiot"
    ;;
  "System of a Down")
    no_albums=3
    last_album="Rock Paper Scissors"
    ;;
  *)
    echo "Invalid Option"
    exit
    ;;

esac

echo $rock_name mahde $no_albums. The Last Album was called \"$last_album\"
