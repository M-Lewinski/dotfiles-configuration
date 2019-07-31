#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# make fast keyboard input
#xset r rate 200 60

# Set trackpoint accel speed
#xinput --set-prop "TPPS/2 IBM TrackPoint" "libinput Accel Speed" 1.0
#xinput --set-prop "TPPS/2 IBM TrackPoint" "libinput Accel Profile Enabled" 0 1

/home/$USER/.dotfiles/keyboard/keyboard_setup.sh

# disable dpms
xset -dpms

# Launch startx
exec i3
