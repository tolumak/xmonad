#!/bin/bash

# Background
#sh ~/.fehbg &

# ICC
#dispwin -I ~/ICC/NC10.icc

# Cursor
xsetroot -cursor_name left_ptr

# Trayer
/usr/bin/stalonetray -bg \#000000 --icon-gravity SE -i 15 -s 16 --geometry 12x1+832+0 --max-geometry 12x1 &

# Launch applications
#xbindkeys &
#nm-applet &
#hillman &
#pidgin &
iceweasel &
#thunderbird &

