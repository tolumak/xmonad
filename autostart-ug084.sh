#!/bin/bash

# Dual screen
xrandr --output LVDS-1 --auto --primary --output VGA-1 --auto --right-of  LVDS-1

# Background
sh ~/.fehbg &

# Cursor
xsetroot -cursor_name left_ptr

# Trayer
/usr/bin/stalonetray -bg \#000000 --icon-gravity SE -i 15 -s 16 --geometry 12x1+1088+0 --max-geometry 12x1

# Launch applications
xbindkeys &
nm-applet &
mount-tray &
pidgin &
firefox &
emacs &
evolution &
