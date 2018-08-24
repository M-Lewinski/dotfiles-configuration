#!/bin/bash

ln -s $HOME/.dotfiles/i3 ~/.config/
chmod 755 $HOME/.dotfiles/i3/backlight/backlightControl
sudo chown root $HOME/.dotfiles/i3/backlight/backlightControl
sudo ln -s $HOME/.dotfiles/i3/backlight/backlightControl /usr/bin/

chmod 755 $HOME/.dotfiles/i3/lock/lock.sh
sudo chown root $HOME/.dotfiles/i3/lock/lock.sh
sudo ln -s $HOME/.dotfiles/i3/lock/lock.sh /usr/bin/lock
echo -e "\nRemember, if you want to use bash script to change backlight brightness, you need to add NOPASSWD for this specific script via visudo.\n"
