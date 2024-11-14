#!/bin/bash

# ICC
#dispwin -I ~/ICC/display.icc

XDG_MENU_PREFIX=plasma- kbuildsycoca6

# Background
sh ~/.fehbg &

# Cursor
xsetroot -cursor_name left_ptr

# Trayer
/usr/bin/stalonetray -bg \#000000 --icon-gravity SE -i 15 -s 16 --geometry 12x1+1126+0 --max-geometry 12x1 &

# Launch applications
light-locker &
xss-lock -- light-locker-command -l &
xbindkeys &
udiskie -A -N -t &
nextcloud &
#firefox &
#thunderbird &

