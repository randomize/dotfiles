#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
   for rcd in /etc/X11/xinit/xinitrc.d/* ; do
      [ -x "$rcd" ] && . "$rcd"
   done
   unset rcd
fi

#exec awesome
#return
#xrandr --setprovideroutputsource modesetting NVIDIA-0
#xrandr --auto

# Manually create
#mkdir -p .cache/rtorrent_session/

# Load settings from X
xrdb -merge ~/.Xresources

# Layout manager
#kbdd & # Not using anymore, has glitch with layouts, not maintained

# Set layouts and no capslock
setxkbmap -layout "dvp, ru" -option "grp:shifts_toggle"

# Make Caps Lock a Control key
# setxkbmap -option ctrl:nocaps 

# Shift+NumLock shortcut toggle mouse keys
# setxkbmap -option "keypad:pointerkeys"

# Right alt is compose
# setxkbmap -option "compose:ralt"

# Turn on c-a-backspace
setxkbmap -option terminate:ctrl_alt_bksp

# Special mappings (see .Xmodmap file)
xmodmap ~/.Xmodmap
# xcape -e '0x1234=Return;Control_L=Escape'
# xcape -e 'Control_L=Escape'

# Set repeat rate to low value
xset r rate 400 80

# make terminus visible for xfontsel and clients
xset +fp /.fonts
xset +fp /usr/share/fonts/local

# Rebuild xdg menu for awesome
xdg_menu --format awesome --root-menu /etc/xdg/menus/arch-applications.menu > ~/.config/awesome/archmenu.lua 

# Conky
#( ( exec conky --pause 1 --config /home/randy/.config/conky/conky.conf ) & )
#( ( exec conky --pause 1 --config /home/randy/.config/conky/left-conky.conf ) & )

# Clipboard manager
( ( sleep 2 && (copyq &) ) & )

# Pulse audio
( ( sleep 2 && (pasystray &) ) & )

# Composition
( ( sleep 1 && exec picom --experimental-backends ) & )

# Mappings
#( ( sleep 1 && exec xbindkeys ) & )

# Gromit
#( ( sleep 3 && exec /usr/bin/gromit-mpx ) & )

# Gromit
# ( ( sleep 2 && exec /usr/bin/albert ) & )

# Set wacom buttons correctly
#xsetwacom --set "Wacom Intuos3 9x12 Pen stylus" Button 2 "button +3"
#xsetwacom --set "Wacom Intuos3 9x12 Pen stylus" Button 3 "button +2"
#xsetwacom --set "Wacom Intuos3 9x12 Pen stylus" "StripLeftDown" "0"
#xsetwacom --set "Wacom Intuos3 9x12 Pen stylus" "StripRightUp" "0"
#xsetwacom --set "Wacom Intuos3 9x12 Pen stylus" "StripRightDown" "0"
#xsetwacom --set "Wacom Intuos3 9x12 Pen stylus" "StripLeftUp" "0"
# xsetwacom --set "Wacom Intuos3 9x12 Pen stylus" PressureCurve x1 y1 x2 y2
# xsetwacom --set "Wacom Intuos3 9x12 Pad pad" Button 8 key "F9" // Note: for normal fn key its fine, but for F20 we bind to mouse button 11 first
#xsetwacom --set "Wacom Intuos3 9x12 Pad pad" Button 8 key "F20"
#xsetwacom --set "Wacom Intuos3 9x12 Pad pad" Button 1 key "shift"
#xsetwacom --set "Wacom Intuos3 9x12 Pad pad" Button 2 key "alt"
#xsetwacom --set "Wacom Intuos3 9x12 Pad pad" Button 3 key "ctrl"


# Start urxvt daemon (quiet, forked, only for this X session)
# urxvtd -q -f -o

# Screensaver
#((sleep 4 && xscreensaver -no-splash -display :0.0 &) & )

# Monitors setup
xrandr --dpi 100
# xrandr --output DP-1 --primary --left-of eDP-1
xrandr --output DP1 --left-of eDP1 --primary --mode 2560x1440
# xrandr --output VGA1 --off
# xrandr --output DP-2 --primary --rotate left
#xrandr --output DP-4.8 --primary --dpi 100
# xrandr --output DP-0 --right-of DP-4 --rotate left
# xrandr --output DP-2 --left-of DP-4 --rotate left
# xrandr --output DVI-D-0 --mode 1280x1024 --right-of DP-0

# Map wacom
#xsetwacom --set "Wacom Intuos3 9x12 Pen stylus" MapToOutput "HEAD-0" 
#xsetwacom --set "Wacom Intuos3 9x12 Pen eraser" MapToOutput "HEAD-0" 

# Disable screen turn off
# xset s off
# Lightons script
#/home/randy/bin/lightsOn.sh &

# Jack
#/home/randy/bin/my-jack-start2

# Mpd
# ( ( sleep 4 && /usr/bin/mpd) & ) #  mpd is started by systemd now, with mpd.service in --user mode

# layout indicator
#( ( sleep 4 && /usr/bin/sbxkb ) & )

# DDC controlled brightness
#( ( sleep 4 && /home/randy/bin/ddc-bright ) & )

# ALSA 2 JACK - MIDI daemon
# ( ( sleep 4 && /usr/bin/a2jmidid -e) & )

# Touchpad tapping enabled - TODO: can these numbers jump? YEP
#xinput set-prop 13 365 1
device=$(xinput list | grep Touchpad | grep -o -P "id=\K(\d+)")
tapping=$(xinput list-props $device | grep -o -Pe "Tapping Enabled \(\d+\)" | grep -o -P "\d+")
xinput set-prop $device $tapping 1

# WM
exec awesome --search ~/.luarocks/lib/luarocks/rocks-5.3/ --search ~/.luarocks/share/lua/5.3
#exec i3
#exec /mnt/data/rdev/dwm-flexipatch/dwm

