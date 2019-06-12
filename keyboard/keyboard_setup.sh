#/usr/bin/bash


setxkbmap pl -option caps:escape

# make fast keyboard input
xset r rate 200 60

# Set trackpoint accel speed
xinput --set-prop "TPPS/2 IBM TrackPoint" "libinput Accel Speed" 1.0
#xinput --set-prop "TPPS/2 IBM TrackPoint" "libinput Accel Profile Enabled" 0 1

