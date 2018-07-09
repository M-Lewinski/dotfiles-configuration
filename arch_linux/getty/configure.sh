#!/bin/bash
echo -e "[Service]
ExecStart=
ExecStart=-/sbin/agetty --autologin $USER --noclear %I" '$TERM' | sudo SYSTEMD_EDITOR=tee systemctl edit getty@tty1.service
