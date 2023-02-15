#!/bin/bash

#FUNCTIONS:

# Help Function
help () {

cat << _HELP_
gzip_archive.sh is a script that will quickly make a backup of a file or restore
a previously backed up file. This is usefull when you are constantly making
changes to files and tinkering on your system. You can make a quick backup
and restore it, if need be.
Usage:
gzip_archive.sh [OPTION] <file1> <file2> <file...>
Flags:
-h    show a help message.
-b    Make a non-compressed backup.
-r    Restore a previously backed up file.
-c    Compress a file and add to backup.
_HELP_
}

# Flag options
# has_n_option=false
# has_r_option=false
# while getopts :hnr opt; do
#         case $opt in
#                 h) help; exit;; #echo "Backup and compress files, skip compression with -n flag and restore with the -r flag."; exit;;
#                 n) has_n_option=true ;;
#                 c) has_c_option=true ;;
# 		r) has_r_option=true ;;
# 		 :) echo "Missing argument for option -$OPTARG"; exit 3;;
#                 \?) echo "Unknown option -$OPTARG"; exit 3;;
#         esac
# done
#
# shift $(( OPTIND -1 ))
#
# Flag Options
has_b_option=false
has_r_option=false
has_c_option=false
while getopts :hbrc opt; do
  case $opt in
    h) help; exit;;
    b) has_b_option=true ;;
    r) has_r_option=true ;;
    c) has_c_option=true ;;
    :) echo "Missing argument for option -$OPTARG"; exit 3;;
    \?) echo "Unknown option -$OPTARG"; exit 3;;
  esac
done

shift $(( OPTIND -1))

#Test to make sure that arguments are entered.
TYPETEST="$@"
if [ -z "$TYPETEST" ]
then
	echo 'Please specify at least one file to backup.'
	exit 3
fi

#Test to make sure that the file is writable
for i in "$@"
do
	if [ ! -w "$i" ]
	then
		echo "Write permission is NOT granted on $i, please run as sudo"
		exit 7
	fi
done

#BACKING UP
# For each $1....$n, do
for i in "$@"
do

	base_file1=$(basename "$i" .gz)		#The base file without extensions
	base_file2=$(basename "$base_file1" .backup)
	location=$(pwd "$i")			#Path to file

	#Non-compression Archiving
	if [[ $has_b_option = true && $has_r_option = false ]]
	then
		echo "Non-compression backup of $i started..."
		#File exists and string is non-zero and doesn't have a .backup* extension
		if [ -e "$i" ] && [ -n "$i" ] && [[ $i != *.backup* ]]
		then
			cp -i "$i" "$i".backup
			echo "NON-COMPRESSED - Archive of $i in $location/ completed on $(date)." | tee -a /home/"$(whoami)"/assign2.log
		#File doesn't exist and the string is non-zero
		elif [ ! -e "$i" ] && [ -n "$i" ]
		then
			echo "$i does not exist. It wasn't backed up!"
		#File already has a .bck* extension
		elif [ -e "$i" ] && [ -n "$i" ] && [[ $i = *.backup* ]]
		then
			echo "Please choose the base file, $base_file2 , to archive, $i seems to already be a backup."
		else
			echo "$i wasn't backed up!, something went wrong!"
		fi
	fi

	# Compression Archiving
	if [[ $has_c_option == true ]] && [[ $has_b_option == false ]] && [[ $has_r_option == false ]]
	then
		echo "Compression backup of $i started..."
		# If file exists and string is not zero and the file isn't a backup and there is no *.bck* in directory already
		if [[ -e $i ]] && [[ -n $i ]] && [[ $i != *.backup* ]] && [[ ! -e $i.backup.gz ]] && [[ ! -e $i.backup ]]
		then
			cp "$i" "$i".backup
			gzip "$i".backup
			echo "COMPRESSED - Archive of $i in $location/ completed on $(date)." | tee -a /home/"$(whoami)"/assign2.log
			gzip -l "$i".backup.gz >> /home/"$(whoami)"/assign2.log

		# If file exists and string is not zero and file.backup* already exist
		elif [[ -e $i ]] && [[ -n $i ]] && [[ -e $1.backup || -e $1.backup.gz ]]
		then
			echo "A backup file of $i already exists "
			if [[ -e $i.backup ]]
			then
				read -r -p "Since you are compressing $i, do you want to delete the existing $i.backup file [Y/N]? " response
				if [[ $response =~ [yY(es)*] ]]
				then
					echo "$1.backup was removed."
					cp "$i" "$i".backup
					gzip -f "$i".backup
					echo "COMPRESSED - Archive of $i to $location/ completed on $(date)." | tee -a /home/"$(whoami)"/assign2.log
					gzip -l "$i".backup.gz >> /home/"$(whoami)"/assign2.log
				else
					echo "$i.backup was preserved."
					cp "$i" "$i".bckz
					gzip "$i".bckz
					mv "$i.bckz.gz" "$i.backup.gz"
					echo "COMPRESSED - Archive of $i to $location/ completed on $(date)." | tee -a /home/"$(whoami)"/assign2.log
					gzip -l "$i".backup.gz >> /home/"$(whoami)"/assign2.log
				fi
			fi

		# If file* doesn't exists and string is not zero
		elif [ ! -e "$i" ] && [ -n "$i" ]
		then
			echo "$i doesn't exist. It wasn't backed up!"
		# IF the compressed archive already exists and is chosen to archive
		elif [ -e "$i" ] && [ -n "$i" ] && [[ $i = *.backup* ]]
		then
			echo "Please choose the base file to archive, $i seems to already be a backup."

		else
			echo "$i wasn't backed up!, something went wrong!"
		fi
	fi
done

#RESTORING
for i in "$@"
do
	if [[ $has_r_option = true ]] && [[ $has_b_option = false ]] && [[ $has_c_option = false ]]
	then
		#echo "Un-Archiving $i"
		if [[ -e $i ]] && [[ "$i" = *.backup ]]
		then
			echo "Restoring Non-Compressed File - $i"
			base=$(basename "$i" .backup)
			location=$(pwd "$i")
			mv "$i" "$base"
			echo "Un-Archive of $i to $location/ , completed on $(date)" | tee -a /home/"$(whoami)"/assign2.log
		elif [[ -e $i ]] && [[ "$i" = *.backup.gz ]]
		then
			echo "Restoring Compressed File - $i"
			gzip -df "$i"
			base=$(basename "$i" .backup.gz)
			# base1=$(basename "$i" newfile.backup.gz)
			location=$(pwd "$i")
			mv "$(basename "$i" .gz)" "$location"/newfile."$base"
			echo "Un-Archive of $i to $location/ , completed on $(date)" | tee -a /home/"$(whoami)"/assign2.log
		elif [[ -e $i ]] && [[ "$i" != *.backup || "$i" != *.backup.gz ]]
		then
			echo "$i doesn't seem to be a supported file! Please choose $i.backup or $i.backup.gz"
		elif [[ ! -e $i ]]
		then
      # exit 7
			echo "$i doesn't exist. It wasn't restored!"
		else
			echo "$i wasn't restored, something went wrong!"
		fi
	fi
done

exit 0
