#!/bin/bash

# ICC
#~/bin/setdisplayprofile.sh

XDG_MENU_PREFIX=plasma- kbuildsycoca6

# Background
sh ~/.fehbg &

# Cursor
xsetroot -cursor_name left_ptr

# Trayer
/usr/bin/stalonetray --icon-gravity SE -i 15 -s 16 --geometry 12x1+2368+0 --max-geometry 12x1 &

# Launch applications
xbindkeys &
killall -9 xiccd
xiccd &
colormgr device-add-profile "xrandr-Ancor Communications Inc-PA279-E2LMQS045051" `colormgr find-profile-by-filename /usr/share/color/icc/colord/PA279Q-D65.icc | grep "Profile ID" | sed 's/.*: *\(.*\)/\1/'`;
colormgr device-add-profile "xrandr-Ancor Communications Inc-PA279-E2LMQS045051" `colormgr find-profile-by-filename /usr/share/color/icc/colord/PA279Q-D50.icc | grep "Profile ID" | sed 's/.*: *\(.*\)/\1/'`;

colormgr device-make-profile-default "xrandr-Ancor Communications Inc-PA279-E2LMQS045051" `colormgr find-profile-by-filename /usr/share/color/icc/colord/PA279Q-D65.icc | grep "Profile ID" | sed 's/.*: *\(.*\)/\1/'`;


light-locker &
xss-lock -- light-locker-command -l &
udiskie -A -N -F -t &
blueberry-tray &
pasystray &
#pidgin &
nextcloud &
#firefox &
#thunderbird &

