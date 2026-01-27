#!/bin/bash

# Your external mouse device name - adjust if needed
MOUSE_NAME="Microsoft"  # or whatever your mouse shows up as

# Check if external mouse is connected
if xinput list | grep -q "$MOUSE_NAME"; then
    # Mouse is connected, start imwheel if not already running
    if ! pgrep -x "imwheel" > /dev/null; then
        imwheel -b "4 5" &
    fi
else
    # Mouse is not connected, kill imwheel
    killall imwheel 2>/dev/null
fi
