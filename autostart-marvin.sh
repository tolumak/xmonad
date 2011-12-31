#!/bin/bash

# ICC
dispwin -I ~/ICC/T190-warm-br33.icc

# Background
sh ~/.fehbg &

# Cursor
xsetroot -cursor_name left_ptr

# Trayer
/usr/bin/stalonetray -bg \#000000 --icon-gravity SE -i 15 -s 16 --geometry 12x1+1248+0 --max-geometry 12x1 &

# Launch applications
eval `ssh-agent`
hillman &
pidgin &
firefox &
thunderbird &
emacs &
