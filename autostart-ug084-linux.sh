#!/bin/bash

# Dual screen
xrandr --output LVDS-1 --auto --primary --gamma 1.0:1.0:1.0 --output VGA-1 --mode 1280x1024 --rate 75  --right-of  LVDS-1 --gamma 0.8:0.8:0.8

# Background
sh ~/.fehbg &

# Cursor
xsetroot -cursor_name left_ptr

# Trayer
/usr/bin/stalonetray -bg \#000000 --icon-gravity SE -i 15 -s 16 --geometry 12x1+1088+0 --max-geometry 12x1 &

# Launch applications
xbindkeys &
nm-applet &
hillman &
pidgin &
firefox &
emacs &
davmail &
thunderbird &
