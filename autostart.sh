#!/bin/bash

# Cursor
xsetroot -cursor_name left_ptr

# Trayer
/usr/bin/trayer --edge top --align right --widthtype percent --width 10 --height 17 --tint 0 --transparent true --alpha 1 --SetDockType true &

# Launch applications
pidgin &
firefox &
kmail &
emacs &
