#!/bin/bash

# ICC
dispwin -I ~/ICC/T190-warm-br33.icc

# Background
sh ~/.fehbg &

# Cursor
xsetroot -cursor_name left_ptr

# Trayer
/usr/bin/trayer --edge top --align right --widthtype percent --width 10 --height 17 --tint 0 --transparent true --alpha 1 --SetDockType true &

# Launch applications
eval `ssh-agent`
mount-tray &
pidgin &
firefox &
thunderbird &
emacs &
