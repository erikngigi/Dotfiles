#!/bin/bash

SELF=$(basename $0)

if [ "$#" -ne 2 ]; then
    echo -e "\nUsage: $SELF [video-file] [subtitle-file]\n"
    exit 1
fi

SRC_FILE="$1"
SRT_FILE="$2"
TITLE="$(echo "$1" | sed 's/\.[^\.]*$//')"
DST_FILE="$TITLE.sub.mkv"
DST_LANG=ind

echo -e "Video\t\t: $SRC_FILE"
echo -e "Subtitle\t: $SRT_FILE"
echo -e "Lang\t\t: $DST_LANG"

mkvmerge \
  -o "$DST_FILE" \
  --title "$TITLE" \
  --default-language "$DST_LANG" \
  --no-subtitles \
  "$SRC_FILE" "$SRT_FILE"

RETVAL=$?

if [ $RETVAL -ne 0 ]; then
        echo -e "\nFAILED!"
else
    	echo -e "\n"
        mediainfo "$DST_FILE"
        echo -e "\n\nSUCCESS: $DST_FILE"
fi

exit $RETVAL
