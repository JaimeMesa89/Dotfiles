#!/bin/bash

# toggle-hyprsunset.sh
# If hyprsunset is running, kill it. Otherwise, start it.

# Check for a running hyprsunset
if pgrep -x hyprsunset > /dev/null; then
    # If found, kill all instances quietly
    killall -q hyprsunset
else
    # Otherwise, launch hyprsunset in the background
    # Adjust flags here if you want a specific temperature or
    # custom step/duration. Below launches with default auto schedule.
    nohup hyprsunset -t 3250 >/dev/null 2>&1 &
fi
