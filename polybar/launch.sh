#!/bin/bash

# Terminate already running polybar instances
killall -q -q polybar

# Wait until the processes have been shut down
# WARNING ACTIVE WAIT
while pgrep -u $UID -x polybar > /dev/null  ;do sleep 1; done

# Launch main bar
for m in $(polybar --list-monitors | cut -d":" -f1); do
    MONITOR=$m polybar --reload main >> $HOME/log/polybar.log 2>&1 &
done

echo "polybar launched"

