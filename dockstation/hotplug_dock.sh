#!/usr/bin/bash

export DISPLAY=:0
export XAUTHORITY=/home/$USER/.Xauthority

set -e
LAPTOP="eDP-1"
MONITOR="DP-2-2"
EXTERNAL_MONITOR_STATUS=`find -L /sys/class/drm/ -maxdepth 2 -name 'status'  2>/dev/null -printf "%p " -exec cat {} \;  | grep -v $LAPTOP | grep " connected"`

function wait_for_monitor {
    xrandr | grep -v $LAPTOP | grep '\bconnected'
    while [ $? -ne 0 ]; do
            sleep 0.1
            xrandr | grep -v $LAPTOP | grep '\bconnected'
    done
}

if [ "$EXTERNAL_MONITOR_STATUS" != "" ]; then
    wait_for_monitor
    xrandr --output $MONITOR --auto
    xrandr --output $LAPTOP --auto --left-of $MONITOR
else
    xrandr --output $MONITOR --off
fi

$HOME/.dotfiles/polybar/launch.sh
/home/$USER/.dotfiles/keyboard/keyboard_setup.sh
feh --bg-scale /home/$USER/.wallpapers/airplanes2.png
