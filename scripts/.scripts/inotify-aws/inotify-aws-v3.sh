#!/bin/bash
# 
# Inotify script that watch the current directory (recursively) for any file changes
# and executes a command when a file is created or modified. 
#
# Function_1: A ffmpeg command that converts all the files in the current directory from
# *.wav format to *.ogg mono 64Kbps format. 
#
# Function_2: Verifies and creates a log file of all the converted audio then deletes the 
# *.wav files in the current directory.
# 
# Function_3: Push the converted *.ogg files to the desired Backblaze B2 bucket and create 
# a log file to verify the file in the local directory and the file in the Backblaze B2 bucket.
# 
# Function_4: Delete the *.ogg file from the current working directory. 
#
# Requirements: Linux, Bash, ffmpeg and inotify-tools
#
# To avoid executing the command multiple times the script waits 10 seconds after the changes. If more changes happen, the timeout is exetended by a another 10 seconds.
#

# declaring the variables

DIRECTORY="$HOME/Git/Development/Clients/ctgreno/05-09-2022-test-01/uploads"
BUCKET_NAME=""
BUCKET_FOLDER=""
LOG_FILE=""

EVENTS="modify,move,create"

# functions
convert_to_ogg() {
  ffmpeg -hide_banner -stats -loglevel panic -i ~/Git/Development/Clients/ctgreno/05-09-2022-test-01/uploads/$file -vn -b:a 640k ~/Git/Development/Clients/ctgreno/05-09-2022-test-01/uploads/${file%.*}.m4a &
  echo -n "Converting $file"
}

while true; do
  inotifywait -m "$DIRECTORY" -e create -e moved_to | while read path action file; do
  if [ ${file##*.} != "ogg" ]; then
    convert_to_ogg
  fi
done

done 
