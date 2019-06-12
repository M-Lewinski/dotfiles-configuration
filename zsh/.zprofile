setxkbmap pl -option caps:escape


if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
	exec startx > $HOME/log/startx.log 2>&1
fi
