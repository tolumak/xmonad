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
colormgr device-add-profile "xrandr-Ancor Communications Inc-PA279-E2LMQS045051" icc-89d4a3db313d812de31120b3ce82f745;
colormgr device-add-profile "xrandr-Ancor Communications Inc-PA279-E2LMQS045051" icc-8b836f6e78b780bdf381314f700c5d55;
colormgr device-add-profile "xrandr-Ancor Communications Inc-PA279-E2LMQS045051" icc-01ec39667a0a7d5eccc161bef857441c;

killall -9 xiccd
xiccd &
light-locker &
udiskie -A -N -F -t &
blueberry-tray &
pasystray &
#pidgin &
nextcloud &
#firefox &
#thunderbird &

