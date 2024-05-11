#!/bin/bash

# ICC
#dispwin -I ~/ICC/display.icc

# Background
sh ~/.fehbg &

# Cursor
xsetroot -cursor_name left_ptr

# Trayer
/usr/bin/stalonetray -bg \#000000 --icon-gravity SE -i 15 -s 16 --geometry 12x1+1126+0 --max-geometry 12x1 &

# Launch applications
eval `ssh-agent`
xbindkeys &
udiskie -A -N -t &
pidgin &
#firefox &
#thunderbird &

