#!/bin/bash
#
# Watches specified directory for changes and copy newly created
# or modified files to Amazon S3 Cloud.

WATCH_DIR="$HOME/Git/Development/Clients/ctgreno/05-09-2022-test-01/uploads"
PID_FILE="/tmp/push2s3.pid"
BUCKET="ericngigi-test"
LOG_FILE="$HOME/Git/Development/Clients/ctgreno/05-09-2022-test-01/logs/"
len=${#WATCH_DIR}

# verify inotify installed
if [ ! -x "/usr/bin/inotifywait" ] ; then
    echo "ERROR: This uses the inotifywait program, which on a Debian-based system is"
    echo "part of the 'inotify-tools' package. Please install that and try again."
    exit 1
fi

# create PID file
echo $$ > $PID_FILE

# file upload
function upload() {
    local path=$1
    local file=$2
    local target=${path:$len}

    aws s3 cp --recursive $path s3://$BUCKET$target
}
function delete() {
    local path=$1
    local file=$2
    local target=${path:$len}

    aws s3 rm s3://$BUCKET$target$file
}

# Creates a log file

if [ ! -d $LOG_FILE ]; then
  mkdir -p $LOG_FILE;
fi

log_file=$LOG_FILE
current_time=$(date "+%Y.%m.%d-%H.%M")
log_file=$log_file.$current_time.log
echo "Log filename: " "$log_file"

# init
inotifywait --recursive --monitor --exclude '.*\.sw[px]*$|4913|~$' $WATCH_DIR |
while read action_dir event_list action_file; do
    if [[ $file =~ .*/\..* ]]; then
        echo "Hidden file ignored"
    else
        case "${event_list}" in
          DELETE* )
            echo "DELETE from s3 $action_dir$action_file"
            delete "$action_dir" "$action_file"
          ;;
        esac

        if [ -f "$action_dir$action_file" ]; then # only process a file, not a directory
            case "${event_list}" in
              CLOSE_WRITE* )
                echo "UPLOAD to s3 $action_dir$action_file"
                upload "$action_dir" "$action_file"
              ;;
              MOVED_TO* )
                echo "UPLOAD to s3 $action_dir$action_file"
                upload "$action_dir" "$action_file"
              ;;
            esac
        fi

        #echo "Got an event $action_dir$action_file $event_list"
    fi
done
