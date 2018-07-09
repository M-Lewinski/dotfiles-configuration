#!/bin/bash

# Terminate already running polybar instances
killall -q -q polybar

# Wait until the processes have been shut down
# WARNING ACTIVE WAIT
while pgrep -u $UID -x polybar > /dev/null  ;do sleep 1; done

# Launch main bar
polybar main > $HOME/log/polybar.log 2>&1 &

echo "polybar launched"

