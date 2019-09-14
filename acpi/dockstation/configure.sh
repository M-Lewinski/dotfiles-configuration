#!/bin/bash

SCRIPT="$HOME/.dotfiles/acpi/dockstation/hotplug_dock.sh"
SCRIPTNAME="hotplug_dock"
sudo ln -s $SCRIPT /usr/local/bin/hotplug_dock

# Use acpi to check for docking station
echo "event=ibm/hotkey LEN0068:00 00000080 00006030
action=su $USER -c $SCRIPTNAME" | sudo tee /etc/acpi/events/thinkpad-dock

#Use acpi to check for undocking
#echo "event=ibm/hotkey LEN0068:00 00000080 00004011
#action=su $USER -c $SCRIPTNAME" | sudo tee /etc/acpi/events/thinkpad-undock
# Use udev (IT'S NOT WORKING!)
#echo "KERNEL==\"card0\", ACTION==\"change\", SUBSYSTEM==\"drm\", ENV{DISPLAY}=\":0\", ENV{XAUTHORITY}=\"/home/$USER/.Xauthority\", RUN+=\"/home/$USER/.dotfiles/dockstation/$SCRIPT\"" | sudo tee /etc/udev/rules.d/90-thinkpad-dock.conf



