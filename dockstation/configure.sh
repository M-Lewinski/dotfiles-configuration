#!/bin/bash

SCRIPT="hotplug_dock.sh"


echo "KERNEL==\"card0\", ACTION==\"change\", SUBSYSTEM==\"drm\", ENV{DISPLAY}=\":0\", ENV{XAUTHORITY}=\"/home/$USER/.Xauthority\", RUN+=\"/home/$USER/.dotfiles/dockstation/$SCRIPT\"" | sudo tee /etc/udev/rules.d/90-thinkpad-dock.conf



