#!/bin/bash

# Background
sh ~/.fehbg &
XDG_MENU_PREFIX=plasma- kbuildsycoca6

# ICC

# Cursor

# Trayer
/usr/bin/stalonetray --icon-gravity SE -i 15 -s 16 --geometry 12x1+1728+0 --max-geometry 12x1 &

# Launch applications
light-locker &
xss-lock -- light-locker-command -l &
xbindkeys &
nm-applet &
pasystray &
nextcloud &
#firefox &
#thunderbird &

