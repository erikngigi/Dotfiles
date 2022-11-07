convert_ogg() {
ffmpeg -hide_banner -nostats -loglevel panic -i ~/audio/convert_to_ogg/$file -vn -b:a 320k ~/audio/convert_to_ogg/${file%.*}.flac &
echo "converting $file"
}

while true; do
inotifywait -m ~/audio/convert_to_ogg -e create -e moved_to | while read path action file; do
if  [ ${file##*.} != "ogg" ]; then
convert_ogg
fi
done
done
