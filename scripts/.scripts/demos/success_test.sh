##!/bin/bash
#Filename: success_test.sh
CMD="command" #Substitute with command for which you need to test the 
exit status
$CMD
if [ $? -eq 0 ];
then
    echo "$CMD executed successfully"
else
    echo "$CMD terminated unsuccessfully"
fi
