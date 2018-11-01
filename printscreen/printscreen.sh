#!/bin/bash

copy_to_clipboard_notify () {
    tee $SCREENSHOT_FILE | xclip -selection clipboard -t image/png
    if [ ! -s $SCREENSHOT_FILE ] ; then
        rm $SCREENSHOT_FILE
    else
        notify-send "Screenshot taken" $SCREENSHOT_FILE -a "Screenshot" -i $SCREENSHOT_FILE
    fi

}

TYPE=0
while test $1
do
    case $1 in
    '-t' | '--type') shift 1
    TYPE=$1;;
    esac
    shift 1
done

if [ "$TYPE" -eq "0" ] ; then
    echo "You need to provide mode number"
    exit 1
fi

SCREENSHOT_DIRECTORY=$HOME/Pictures/Screenshots/`date -I | tr -d "-"`
mkdir -p $SCREENSHOT_DIRECTORY
SCREENSHOT_FILE=$SCREENSHOT_DIRECTORY/$( date -Ins | cut -f 1 -d "+" | tr -d "-" | tr -d ":," ).png

case $TYPE in
    "1") maim -u -x :0.0 -f png -m 10 | copy_to_clipboard_notify;;
    "2") maim -u -x :0.0 -f png -m 10 -s -n -l -c 0.157,0.333,0.466,0.4 | copy_to_clipboard_notify;;
    *) echo -e "Provided type is not valid"
    rmdir SCREENSHOT_DIRECTORY  > /dev/null 2>&1
    exit 2;;
esac
rmdir SCREENSHOT_DIRECTORY  > /dev/null 2>&1
