#!/bin/bash

# Set the screenshot directory and filename
screenshot_dir="/home/junk/Pictures/Screenshots"
filename="screenshot-$(date '+%Y-%m-%d_%H-%M-%S').png"
filepath="$screenshot_dir/$filename"

# Check if the -s parameter is passed
if [ "$1" == "-s" ]; then
    grim -g "$(slurp)" - | tee "$filepath" | wl-copy --type image/png
else
    grim -o DP-1 - | tee "$filepath" | wl-copy --type image/png
fi
