#!/bin/bash


# Send notification when battery reach 0-15%
echo "SUBSYSTEM==\"power_supply\", ATTR{status}==\"Discharging\", ATTR{capacity}==\"[0-15]\", RUN+=\"/usr/bin/notify-send -u critical -a \"low battery!\" \"low battery!\" \"Low battery!\"" | sudo tee /etc/udev/rules.d/99-lowbat.conf



