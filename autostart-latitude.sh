#!/bin/bash

# Background
#sh ~/.fehbg &

# ICC

# Cursor

# Trayer
/usr/bin/stalonetray --icon-gravity SE -i 15 -s 16 --geometry 12x1+1728+0 --max-geometry 12x1 &

# Launch applications
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
xbindkeys &
nm-applet &
pasystray &
#firefox &
#thunderbird &

