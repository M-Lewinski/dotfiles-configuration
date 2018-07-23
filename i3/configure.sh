#!/bin/bash

ln -s $HOME/.dotfiles/i3 ~/.config/
chmod 755 $HOME/.dotfiles/i3/backlight/backlightControl
sudo chown root $HOME/.dotfiles/i3/backlight/backlightControl
sudo ln -s $HOME/.dotfiles/i3/backlight/backlightControl /usr/bin/

echo -e "\nRemember, if you want to use bash script to change backlight brightness, you need to add NOPASSWD for this specific script via visudo.\n"
