#!/bin/bash
echo -e "[Unit]
Description=lock screen on suspend
Before=sleep.target

[Service]
User=$USER
Environment=DISPLAY=:0
ExecStart=/usr/bin/lock
ExecStartPost=/usr/bin/sleep 1

[Install]
WantedBy=sleep.target" | sudo tee /etc/systemd/system/screenlock.service 
