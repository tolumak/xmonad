#!/bin/bash

# Cursor
xsetroot -cursor_name left_ptr

# Screensaver off
xset s off

# DPMS delays
xset dpms 0 300 1200

# Trayer
/usr/bin/trayer --edge top --align right --widthtype percent --width 10 --height 17 --tint 0 --transparent true --alpha 1 --SetDockType true &

# Launch applications
eval `ssh-agent`
mount-tray &
firefox &
emacs &
~/bin/mail_tunnel.sh
pidgin &
thunderbird &
