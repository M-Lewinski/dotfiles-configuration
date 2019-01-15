#!/bin/bash

echo "Checking OS health"

# Checking empty space on mounted disks
PERCENT="[8-9][0-9]%"

if df -h | grep -q -e $PERCENT ; then
	FULLDISKS=$( df -h | tail -n +2 | tr -s " " | cut -f-1,5 -d " " | grep -e $PERCENT )
	MSG="Disk space check"
	echo $FULLDISKS
	notify-send -u critical -a "$MSG" "$MSG" "There is not enough space on disks:\n$FULLDISKS"
fi

PRINTSCREEN_DIRECTORY=$HOME/Pictures/Screenshots
PRINTSCREEN_THRESHOLD="\([0-9+][0-9]\|[5-9]\)G"
if [ -d $PRINTSCREEN_DIRECTORY ] ; then
	if du -sh $PRINTSCREEN_DIRECTORY | grep -q -e $PRINTSCREEN_THRESHOLD ; then
		MSG="Print screen directory"
		notify-send -u critical -a $MSG $MSG "Directory where printscreens are saved, takes a lot of space\n
		$PRINTSCREEN_DIRECTORY"
	fi
fi
