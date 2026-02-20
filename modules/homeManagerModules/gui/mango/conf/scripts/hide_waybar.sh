#!/usr/bin/bash

startd=$(pgrep waybar)

if [ -n "$startd" ]; then
	pkill waybar
else
	waybar
fi
