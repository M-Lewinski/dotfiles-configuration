setxkbmap pl -option caps:escape


if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
	exec startx > $HOME/log/startx.log 2>&1
fi
