#!/bin/bash

# Set the screenshot directory and filename
screenshot_dir="/home/junk/Pictures/Screenshots"
filename="screenshot-$(date '+%Y-%m-%d_%H-%M-%S').png"
filepath="$screenshot_dir/$filename"

# Check if the -s parameter is passed
if [ "$1" == "-s" ]; then
    grim -g "$(slurp)" "$filepath"
else
    grim "$filepath"
fi
