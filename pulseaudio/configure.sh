#!/bin/bash

ln -s $HOME/.dotfiles/pulseaudio/default.pa $HOME/.config/pulse/

#echo "[FIX] Creating Systemd service to fix no audio after suspend"
#SERVICENAME=pulseaudio-suspend-fix.service
#echo -e "[Unit]
#Description=Fix PulseAudio after resume from suspend
#After=suspend.target
#
#[Service]
#User=$USER
#Type=oneshot
#Environment="XDG_RUNTIME_DIR=/run/user/$UID"
#ExecStart=/usr/bin/pasuspender /bin/true
#
#[Install]
#WantedBy=suspend.target" | sudo tee /etc/systemd/system/$SERVICENAME
#
#sudo systemctl enable $SERVICENAME
#sudo systemctl --system daemon-reload
#
