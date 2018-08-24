#!/bin/bash
echo -e "[Unit]
Description=lock screen on suspend
Before=sleep.target

[Service]
User=$USER
Environment=DISPLAY=:0
ExecStartPre=/usr/bin/xset dpms force suspend
ExecStart=/usr/bin/lock

[Install]
WantedBy=sleep.target" | sudo tee /etc/systemd/system/screenlock.service 
