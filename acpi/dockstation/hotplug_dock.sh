#!/usr/bin/bash
logger "ACPI event: $*"

export DISPLAY=:0
export XAUTHORITY=/home/$USER/.Xauthority

SLEEPTIME=0.1
MAXTRIES=100
TRIES=0
SIDE="--left-of"
#Laptop monitor
LAPTOP="eDP-1"
#Defualt external monitor
MONITOR="DP-2-2"
#Check if external monitor is connected. Sometimes xrandr doesn't see external monitor immediately after connecting
EXTERNAL_MONITOR_STATUS=`find -L /sys/class/drm/ -maxdepth 2 -name 'status'  2>/dev/null -printf "%p " -exec cat {} \;  | grep -v $LAPTOP | grep " connected"`

while test $1
do
    case $1 in
    '-l' | '--left-of') shift 1
    SIDE="--left-of";;
    '-r' | '--right-of') shift 1
    SIDE="--right-of";;
    *) echo -e "Wrong parameter $1"
    exit 1;;
    esac
    shift 1
done

function wait_for_monitor {
    xrandr  -d :0.0  | grep -v $LAPTOP | grep '\bconnected'
    while [ $? -ne 0 ]; do
           TRIES=$((TRIES+1))
            sleep $SLEEPTIME
            xrandr  -d :0.0  | grep -v $LAPTOP | grep '\bconnected'
            if [ "$TRIES" -eq "$MAXTRIES"  ]; then
                exit 1;
            fi
    done
    MONITOR=`xrandr  -d :0.0  | grep -v $LAPTOP | grep '\bconnected'| cut -f 1 -d " "`      
}

if [ "$EXTERNAL_MONITOR_STATUS" != "" ]; then
    wait_for_monitor
    xrandr  -d :0.0  --output $MONITOR --auto --primary $SIDE $LAPTOP
else
    xrandr  -d :0.0  --output $MONITOR --off
fi

$HOME/.dotfiles/keyboard/keyboard_setup.sh
feh --bg-scale $HOME/.wallpapers/airplanes2.png
sleep 4
$HOME/.dotfiles/polybar/launch.sh
