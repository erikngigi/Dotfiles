#!/usr/bin/env bash
#
# Watch specified directory recursively for file changes, and sync it to S3 when anything is
# created, modified, moved or deleted. Designed for use with a static site generator.
#
# Originally based on a script by Senko Rasic <senko.rasic@dobarkod.hr>
# Modified by Tim Malone <tdmalone@gmail.com>
# Ideas included from Lambros Petrou <lambrospetrou@gmail.com>
# Released to public domain.
# See https://gist.github.com/senko/1154509
# See https://www.lambrospetrou.com/articles/aws-s3-sync-git-status/
#
# Requires Linux, bash, git and inotifywait (from inotify-tools package).
#
# To avoid executing the command multiple times when a sequence of events happen, the script waits
# one second after the change - if more changes happen, the timeout is extended by a second again.
#
# S3 sync supports a custom storage class (choose from STANDARD, REDUCED_REDUNDANCY or STANDARD_IA)
# as well as a custom content type for HTML files (useful for specifying the charset).
#
# A git repo is used within the watched directory to ensure that only files that have really
# changed are synced.
#
# XML files are ignored and deleted; this is a bit of a hack but is currently the quickest way to
# avoid my static site generator from re-generating dated RSS feed files each time!
#

DIRECTORY="/var/www/aws.tm.id.au_static"
BUCKET="s3://static.tm.id.au"
LOG_FILE="/var/log/tm-watch.log"

EVENTS="modify,move,create,delete"
STORAGE_CLASS="REDUCED_REDUNDANCY"
HTML_CONTENT_TYPE="text/html;charset=UTF-8"

echo "Watching for changes. All output will be logged to ${LOG_FILE}."
echo "Watching for changes..." >> "${LOG_FILE}"

inotifywait --event "$EVENTS" --monitor --recursive --format '%:e %f' --exclude "(/\.git/|\.sw(p|x|px)$)" "$DIRECTORY"/ | (

  WAITING="";

  while true; do
    LINE="";
    read -t 1 LINE;
    if test -z "$LINE"; then
      if test ! -z "$WAITING"; then
        echo "CHANGE";
        WAITING="";
      fi;
    else
      WAITING=1;
    fi;
  done

) | (

  while true; do

    read TMP;

    echo "Change detected; checking git to determine which files have *really* been modified..." >> "${LOG_FILE}"

    FILES=()

    for file in $( git --git-dir="${DIRECTORY}/.git" --work-tree="${DIRECTORY}" status --short | sed 's/\s*[a-zA-Z?]\+ \(.*\)/\1/' ); do

      extension="${file##*.}"
      content_type_arg=""

      FILES+=("${file}")

      # Add content-type for HTML files.
      if [ "html" = "${extension}" ]; then
        content_type_arg="--content-type ${HTML_CONTENT_TYPE}"
      fi

      # If the file is XML, remove it, otherwise sync the file to S3.
      if [ "xml" = "${extension}" ]; then
        echo "Removing ${file}." >> "${LOG_FILE}"
        rm "${DIRECTORY}/${file}"
      else
        /usr/local/bin/aws s3 sync "${DIRECTORY}"/ "${BUCKET}" \
          --delete \
          --exclude '*' \
          --include "${file}" \
          --storage-class "${STORAGE_CLASS}" \
          ${content_type_arg} \
          >> "${LOG_FILE}" 2>&1
      fi

      # Stage the file with git.
      git \
        --git-dir="${DIRECTORY}/.git" \
        --work-tree="${DIRECTORY}" \
        add "${file}" \
        >> "${LOG_FILE}" 2>&1

    done

    if [ -n "${FILES[*]}" ]; then

      echo "Storing changes in git..." >> "${LOG_FILE}"

      git \
        --git-dir="${DIRECTORY}/.git" \
        --work-tree="${DIRECTORY}" \
        -c commit.gpgsign=false \
        commit \
        --message="Synced ${#FILES[@]} to S3." \
        >> "${LOG_FILE}" 2>&1

    else
      echo "No changes detected." >> "${LOG_FILE}"
    fi

    echo "Ready for more changes." >> "${LOG_FILE}"

  done

)
